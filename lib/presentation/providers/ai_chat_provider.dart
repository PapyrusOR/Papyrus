import 'dart:async';
import 'package:flutter/material.dart';
import '../../data/models/ai_config_model.dart';
import '../../data/models/ai_session_model.dart';
import '../../data/models/card_model.dart';
import '../../data/repositories/ai_config_repository.dart';
import '../../data/repositories/card_repository.dart';
import 'session_provider.dart';
import '../../ai/models/ai_message.dart';
import '../../ai/providers/ai_provider_interface.dart';
import '../../ai/providers/openai_compatible_provider.dart';
import '../../ai/providers/ollama_provider.dart';
import '../../ai/services/ai_request_service.dart';
import '../../ai/services/tool_parser.dart';
import '../../ai/tools/tool_executor.dart';

class AIChatProvider extends ChangeNotifier {
  final AIConfigRepository _configRepository;
  final CardRepository _cardRepository;
  final SessionProvider _sessionProvider;

  AIChatProvider(
    this._configRepository,
    this._cardRepository,
    this._sessionProvider,
  ) {
    _initialize();
  }

  AIConfigModel? _config;
  bool _isAvailable = false;
  bool _isLoading = false;
  bool _isStreaming = false;
  bool _agentMode = false;
  String? _error;
  String _currentStreamContent = '';
  StreamSubscription<AIStreamChunk>? _streamSubscription;

  bool get isAvailable => _isAvailable;
  bool get isLoading => _isLoading;
  bool get isStreaming => _isStreaming;
  bool get agentMode => _agentMode;
  String? get error => _error;
  String get currentStreamContent => _currentStreamContent;

  List<MessageModel> get messages {
    return _sessionProvider.activeSession?.messages ?? [];
  }

  Future<void> _initialize() async {
    try {
      _config = await _configRepository.load();
      _checkAvailability();
    } catch (_) {
      _isAvailable = false;
    }
    notifyListeners();
  }

  void _checkAvailability() {
    if (_config == null) {
      _isAvailable = false;
      return;
    }
    final provider = _config!.currentProvider;
    if (provider == null) {
      _isAvailable = false;
      return;
    }
    final pConfig = _config!.providers[provider];
    _isAvailable = pConfig != null && pConfig.baseUrl.isNotEmpty;
  }

  void toggleAgentMode() {
    _agentMode = !_agentMode;
    notifyListeners();
  }

  Future<void> sendMessage(String userMessage, {CardModel? currentCard, bool isQuestionState = true}) async {
    if (userMessage.trim().isEmpty) return;
    if (!_isAvailable || _config == null) {
      _error = 'AI 助手未配置';
      notifyListeners();
      return;
    }

    _error = null;
    _isLoading = true;
    _isStreaming = true;
    _currentStreamContent = '';
    notifyListeners();

    // 保存用户消息
    await _sessionProvider.addMessageToActiveSession('user', userMessage);

    // 构建历史消息（转换为 AIMessage）
    final history = messages
        .where((m) => m.role != 'system')
        .map((m) => AIMessage(
              role: m.role == 'assistant' ? AIMessageRole.assistant : AIMessageRole.user,
              content: m.content,
            ))
        .toList();

    // 构建请求
    final request = AIRequestService.buildChatRequest(
      config: _config!,
      history: history,
      userMessage: userMessage,
      currentCard: currentCard,
      isQuestionState: isQuestionState,
      agentMode: _agentMode,
    );

    // 获取提供商
    final provider = _getProvider();
    final providerConfig = _config!.providers[_config!.currentProvider!];
    if (provider == null || providerConfig == null) {
      _error = '无效的提供商配置';
      _isLoading = false;
      _isStreaming = false;
      notifyListeners();
      return;
    }

    // 发送请求
    try {
      final stream = provider.chatComplete(providerConfig, request);
      _streamSubscription = stream.listen(
        (chunk) {
          if (chunk.content != null) {
            _currentStreamContent += chunk.content!;
            notifyListeners();
          }
          if (chunk.isDone || chunk.finishReason != null) {
            _finishStream();
          }
        },
        onError: (e) {
          _error = '请求失败: $e';
          _finishStream();
        },
        onDone: () {
          if (_isStreaming) {
            _finishStream();
          }
        },
      );
    } catch (e) {
      _error = '请求异常: $e';
      _isLoading = false;
      _isStreaming = false;
      notifyListeners();
    }
  }

  void _finishStream() {
    _isStreaming = false;
    _isLoading = false;

    // 保存 AI 回复
    if (_currentStreamContent.isNotEmpty) {
      _sessionProvider.addMessageToActiveSession('assistant', _currentStreamContent);

      // Agent 模式：检查是否包含工具调用
      if (_agentMode && ToolParser.hasToolCall(_currentStreamContent)) {
        final toolCall = ToolParser.parse(_currentStreamContent);
        if (toolCall != null) {
          _executeTool(toolCall);
        }
      }
    }

    _currentStreamContent = '';
    notifyListeners();
  }

  Future<void> _executeTool(ToolCall call) async {
    final executor = ToolExecutor(_cardRepository);
    final result = await executor.execute(call);
    await _sessionProvider.addMessageToActiveSession('system', '工具执行结果: $result');
    notifyListeners();
  }

  AIProvider? _getProvider() {
    final providerName = _config?.currentProvider;
    if (providerName == null) return null;

    if (providerName == 'ollama') {
      return OllamaProvider();
    }
    return OpenAICompatibleProvider();
  }

  Future<void> refreshConfig() async {
    await _initialize();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
