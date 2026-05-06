import '../../data/models/ai_config_model.dart';
import '../models/ai_message.dart';

abstract class AIProvider {
  String get name;

  /// 从提供商 API 获取可用模型列表
  Future<List<String>> fetchModels(AIProviderConfig config);

  /// 发送聊天请求，返回流式响应
  /// 
  /// [config]: 提供商配置（apiKey, baseUrl）
  /// [request]: AI 请求参数
  Stream<AIStreamChunk> chatComplete(AIProviderConfig config, AIRequest request);
}
