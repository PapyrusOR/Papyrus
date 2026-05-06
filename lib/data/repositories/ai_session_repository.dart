import '../models/ai_session_model.dart';

abstract class AISessionRepository {
  Future<AISessionDataModel?> load();
  Future<void> save(AISessionDataModel data);
}
