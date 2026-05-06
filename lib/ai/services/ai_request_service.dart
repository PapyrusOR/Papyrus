import '../../data/models/ai_config_model.dart';
import '../../data/models/card_model.dart';
import '../models/ai_message.dart';

/// 组装 AI 请求，注入当前卡片上下文和系统提示词
class AIRequestService {
  AIRequestService._();

  static AIRequest buildChatRequest({
    required AIConfigModel config,
    required List<AIMessage> history,
    required String userMessage,
    CardModel? currentCard,
    bool isQuestionState = true,
    bool agentMode = false,
  }) {
    final messages = <AIMessage>[];

    // 系统提示词
    final systemPrompt = _buildSystemPrompt(
      currentCard: currentCard,
      isQuestionState: isQuestionState,
      agentMode: agentMode,
    );
    messages.add(AIMessage(role: AIMessageRole.system, content: systemPrompt));

    // 历史消息（限制上下文长度）
    final contextLength = config.features.contextLength;
    final recentHistory = history.length > contextLength
        ? history.sublist(history.length - contextLength)
        : history;
    messages.addAll(recentHistory);

    // 用户当前消息
    messages.add(AIMessage(role: AIMessageRole.user, content: userMessage));

    return AIRequest(
      model: config.currentModel ?? '',
      messages: messages,
      temperature: config.parameters.temperature,
      topP: config.parameters.topP,
      maxTokens: config.parameters.maxTokens,
      presencePenalty: config.parameters.presencePenalty,
      frequencyPenalty: config.parameters.frequencyPenalty,
      stream: true,
    );
  }

  static String _buildSystemPrompt({
    CardModel? currentCard,
    required bool isQuestionState,
    required bool agentMode,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('你是 Papyrus 的 AI 学习助手，帮助用户进行间隔重复学习。');

    if (currentCard != null) {
      buffer.writeln();
      buffer.writeln('当前学习卡片:');
      buffer.writeln('题目: ${currentCard.q}');
      if (!isQuestionState) {
        buffer.writeln('答案: ${currentCard.a}');
      }
      buffer.writeln('状态: ${isQuestionState ? "题目面（用户尚未查看答案）" : "答案面"}');
    }

    if (agentMode) {
      buffer.writeln();
      buffer.writeln('你处于 Agent 模式。你可以通过以下 JSON 格式调用工具来操作卡片数据:');
      buffer.writeln('```json');
      buffer.writeln('{');
      buffer.writeln('  "tool": "create_card",');
      buffer.writeln('  "params": {"question": "...", "answer": "...", "tags": []}');
      buffer.writeln('}');
      buffer.writeln('```');
      buffer.writeln('可用工具: create_card, update_card, delete_card, search_cards, get_card_stats');
    }

    return buffer.toString();
  }
}
