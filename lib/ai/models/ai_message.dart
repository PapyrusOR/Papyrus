import '../../data/models/ai_session_model.dart';

enum AIMessageRole { system, user, assistant }

class AIMessage {
  final AIMessageRole role;
  final String content;
  final List<AttachmentModel> attachments;

  AIMessage({
    required this.role,
    required this.content,
    this.attachments = const [],
  });

  Map<String, dynamic> toOpenAIFormat() {
    return {
      'role': role.name,
      'content': content,
    };
  }
}

class AIRequest {
  final String model;
  final List<AIMessage> messages;
  final double temperature;
  final double topP;
  final int maxTokens;
  final double presencePenalty;
  final double frequencyPenalty;
  final bool stream;

  AIRequest({
    required this.model,
    required this.messages,
    this.temperature = 0.7,
    this.topP = 0.9,
    this.maxTokens = 2000,
    this.presencePenalty = 0.0,
    this.frequencyPenalty = 0.0,
    this.stream = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'messages': messages.map((m) => m.toOpenAIFormat()).toList(),
      'temperature': temperature,
      'top_p': topP,
      'max_tokens': maxTokens,
      'presence_penalty': presencePenalty,
      'frequency_penalty': frequencyPenalty,
      'stream': stream,
    };
  }
}

class AIStreamChunk {
  final String? content;
  final String? finishReason;
  final bool isDone;

  AIStreamChunk({
    this.content,
    this.finishReason,
    this.isDone = false,
  });
}
