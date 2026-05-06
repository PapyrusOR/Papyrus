import 'package:drift/drift.dart';
import '../local/app_database.dart';
import '../models/ai_config_model.dart';
import 'ai_config_repository.dart';

class AIConfigRepositoryImpl implements AIConfigRepository {
  final AppDatabase _db;

  AIConfigRepositoryImpl(this._db);

  @override
  Future<AIConfigModel?> load() async {
    final settings = await _db.select(_db.aiSettings).getSingleOrNull();
    if (settings == null) return null;

    final providerRows = await _db.select(_db.aiProviders).get();
    final providers = <String, AIProviderConfig>{};
    for (final row in providerRows) {
      final modelRows = await (_db.select(_db.aiProviderModels)
            ..where((m) => m.providerId.equals(row.id)))
          .get();
      providers[row.id] = AIProviderConfig(
        apiKey: row.apiKey,
        baseUrl: row.baseUrl,
        models: modelRows.map((m) => m.modelName).toList(),
      );
    }

    return AIConfigModel(
      providers: providers,
      currentProvider: settings.currentProvider,
      currentModel: settings.currentModel,
      parameters: AIParameters(
        temperature: settings.temperature,
        topP: settings.topP,
        maxTokens: settings.maxTokens,
        presencePenalty: settings.presencePenalty,
        frequencyPenalty: settings.frequencyPenalty,
      ),
      features: AIFeatures(
        autoHint: settings.autoHint,
        autoExplain: settings.autoExplain,
        contextLength: settings.contextLength,
      ),
    );
  }

  @override
  Future<void> save(AIConfigModel config) async {
    await _db.transaction(() async {
      // 保存 providers
      await _db.delete(_db.aiProviders).go();
      await _db.delete(_db.aiProviderModels).go();
      for (final entry in config.providers.entries) {
        await _db.into(_db.aiProviders).insert(AiProvidersCompanion(
              id: Value(entry.key),
              apiKey: Value(entry.value.apiKey),
              baseUrl: Value(entry.value.baseUrl),
            ));
        for (final model in entry.value.models) {
          await _db.into(_db.aiProviderModels).insert(AiProviderModelsCompanion(
                providerId: Value(entry.key),
                modelName: Value(model),
              ));
        }
      }

      // 保存 settings
      await _db.into(_db.aiSettings).insertOnConflictUpdate(AiSettingsCompanion(
            id: const Value(1),
            currentProvider: Value(config.currentProvider),
            currentModel: Value(config.currentModel),
            temperature: Value(config.parameters.temperature),
            topP: Value(config.parameters.topP),
            maxTokens: Value(config.parameters.maxTokens),
            presencePenalty: Value(config.parameters.presencePenalty),
            frequencyPenalty: Value(config.parameters.frequencyPenalty),
            autoHint: Value(config.features.autoHint),
            autoExplain: Value(config.features.autoExplain),
            contextLength: Value(config.features.contextLength),
          ));
    });
  }
}
