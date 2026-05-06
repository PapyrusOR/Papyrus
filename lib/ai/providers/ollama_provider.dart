import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';
import '../../data/models/ai_config_model.dart';
import '../models/ai_message.dart';
import 'ai_provider_interface.dart';

class OllamaProvider implements AIProvider {
  @override
  String get name => 'Ollama';

  @override
  Future<List<String>> fetchModels(AIProviderConfig config) async {
    final uri = Uri.parse('${config.baseUrl}/api/tags');
    final response = await http.get(uri)
        .timeout(AppConstants.ollamaApiTimeout);

    if (response.statusCode != 200) {
      throw Exception('获取模型列表失败: ${response.statusCode} ${response.body}');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final models = json['models'] as List<dynamic>? ?? [];
    return models.map((m) => (m as Map<String, dynamic>)['name'] as String).toList();
  }

  @override
  Stream<AIStreamChunk> chatComplete(AIProviderConfig config, AIRequest request) async* {
    final uri = Uri.parse('${config.baseUrl}/api/chat');
    
    // Ollama 的 API 格式与 OpenAI 略有不同
    final body = {
      'model': request.model,
      'messages': request.messages.map((m) => {
        'role': m.role.name,
        'content': m.content,
      }).toList(),
      'stream': true,
      'options': {
        'temperature': request.temperature,
        'top_p': request.topP,
        'num_predict': request.maxTokens,
      },
    };

    final client = http.Client();
    try {
      final httpRequest = http.Request('POST', uri)
        ..headers['Content-Type'] = 'application/json'
        ..body = jsonEncode(body);

      final response = await client.send(httpRequest)
          .timeout(AppConstants.ollamaApiTimeout);

      if (response.statusCode != 200) {
        final bodyStr = await response.stream.bytesToString();
        throw Exception('请求失败: ${response.statusCode} $bodyStr');
      }

      await for (final chunk in response.stream.transform(utf8.decoder)) {
        final lines = chunk.split('\n');
        for (final line in lines) {
          final trimmed = line.trim();
          if (trimmed.isEmpty) continue;

          try {
            final json = jsonDecode(trimmed) as Map<String, dynamic>;
            final message = json['message'] as Map<String, dynamic>?;
            final content = message?['content'] as String?;
            final done = json['done'] as bool? ?? false;

            if (content != null || done) {
              yield AIStreamChunk(
                content: content,
                isDone: done,
              );
            }
          } catch (_) {
            // 忽略无法解析的行
          }
        }
      }
    } finally {
      client.close();
    }
  }
}
