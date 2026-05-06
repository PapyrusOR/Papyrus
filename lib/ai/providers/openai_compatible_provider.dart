import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';
import '../../data/models/ai_config_model.dart';
import '../models/ai_message.dart';
import 'ai_provider_interface.dart';

class OpenAICompatibleProvider implements AIProvider {
  @override
  String get name => 'OpenAI Compatible';

  @override
  Future<List<String>> fetchModels(AIProviderConfig config) async {
    final uri = Uri.parse('${config.baseUrl}/models');
    final response = await http.get(
      uri,
      headers: _buildHeaders(config),
    ).timeout(AppConstants.defaultApiTimeout);

    if (response.statusCode != 200) {
      throw Exception('获取模型列表失败: ${response.statusCode} ${response.body}');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final data = json['data'] as List<dynamic>? ?? [];
    return data.map((m) => (m as Map<String, dynamic>)['id'] as String).toList();
  }

  @override
  Stream<AIStreamChunk> chatComplete(AIProviderConfig config, AIRequest request) async* {
    final uri = Uri.parse('${config.baseUrl}/chat/completions');
    final requestBody = request.toJson();

    final client = http.Client();
    try {
      final httpRequest = http.Request('POST', uri)
        ..headers.addAll(_buildHeaders(config))
        ..body = jsonEncode(requestBody);

      final response = await client.send(httpRequest)
          .timeout(AppConstants.defaultApiTimeout);

      if (response.statusCode != 200) {
        final body = await response.stream.bytesToString();
        throw Exception('请求失败: ${response.statusCode} $body');
      }

      await for (final chunk in response.stream.transform(utf8.decoder)) {
        final lines = chunk.split('\n');
        for (final line in lines) {
          final trimmed = line.trim();
          if (trimmed.isEmpty || !trimmed.startsWith('data: ')) continue;
          
          final data = trimmed.substring(6);
          if (data == '[DONE]') {
            yield AIStreamChunk(isDone: true);
            continue;
          }

          try {
            final json = jsonDecode(data) as Map<String, dynamic>;
            final choices = json['choices'] as List<dynamic>? ?? [];
            if (choices.isEmpty) continue;

            final delta = choices[0]['delta'] as Map<String, dynamic>? ?? {};
            final content = delta['content'] as String?;
            final finishReason = choices[0]['finish_reason'] as String?;

            if (content != null || finishReason != null) {
              yield AIStreamChunk(
                content: content,
                finishReason: finishReason,
              );
            }
          } catch (_) {
            // 忽略无法解析的 SSE 行
          }
        }
      }
    } finally {
      client.close();
    }
  }

  Map<String, String> _buildHeaders(AIProviderConfig config) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (config.apiKey != null && config.apiKey!.isNotEmpty) {
      headers['Authorization'] = 'Bearer ${config.apiKey}';
    }
    return headers;
  }
}
