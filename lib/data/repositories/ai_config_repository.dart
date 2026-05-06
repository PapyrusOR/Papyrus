import '../models/ai_config_model.dart';

abstract class AIConfigRepository {
  Future<AIConfigModel?> load();
  Future<void> save(AIConfigModel config);
}
