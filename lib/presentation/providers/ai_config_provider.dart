import 'package:flutter/material.dart';
import '../../core/utils/validators.dart';
import '../../data/models/ai_config_model.dart';
import '../../data/repositories/ai_config_repository.dart';

class AIConfigProvider extends ChangeNotifier {
  final AIConfigRepository _repository;

  AIConfigProvider(this._repository) {
    _loadConfig();
  }

  AIConfigModel _config = AIConfigModel();
  bool _isLoading = false;
  bool _hasChanges = false;
  Map<String, String?> _validationErrors = {};

  AIConfigModel get config => _config;
  bool get isLoading => _isLoading;
  bool get hasChanges => _hasChanges;
  Map<String, String?> get validationErrors => _validationErrors;

  bool get isConfigured {
    final provider = _config.currentProvider;
    if (provider == null) return false;
    final pConfig = _config.providers[provider];
    return pConfig != null && pConfig.baseUrl.isNotEmpty;
  }

  Future<void> _loadConfig() async {
    _isLoading = true;
    notifyListeners();

    final loaded = await _repository.load();
    if (loaded != null) {
      _config = loaded;
    }

    _isLoading = false;
    notifyListeners();
  }

  void setProvider(String provider) {
    _config = _config.copyWith(currentProvider: provider);
    _hasChanges = true;
    notifyListeners();
  }

  void setModel(String model) {
    _config = _config.copyWith(currentModel: model);
    _hasChanges = true;
    notifyListeners();
  }

  void updateProviderConfig(String providerName, AIProviderConfig providerConfig) {
    final newProviders = Map<String, AIProviderConfig>.from(_config.providers);
    newProviders[providerName] = providerConfig;
    _config = _config.copyWith(providers: newProviders);
    _hasChanges = true;
    notifyListeners();
  }

  void updateParameters(AIParameters parameters) {
    _config = _config.copyWith(parameters: parameters);
    _hasChanges = true;
    notifyListeners();
  }

  void addModel(String providerName, String model) {
    final current = _config.providers[providerName];
    if (current == null) return;
    final newModels = List<String>.from(current.models)..add(model);
    updateProviderConfig(providerName, current.copyWith(models: newModels));
  }

  void removeModel(String providerName, String model) {
    final current = _config.providers[providerName];
    if (current == null || current.models.length <= 1) return;
    final newModels = List<String>.from(current.models)..remove(model);
    updateProviderConfig(providerName, current.copyWith(models: newModels));
  }

  bool validate() {
    _validationErrors = {};

    final provider = _config.currentProvider;
    if (provider == null) {
      _validationErrors['provider'] = '请选择一个提供商';
      notifyListeners();
      return false;
    }

    final pConfig = _config.providers[provider];
    if (pConfig == null) {
      _validationErrors['provider'] = '提供商配置不存在';
      notifyListeners();
      return false;
    }

    // ASCII 校验
    if (pConfig.apiKey != null && pConfig.apiKey!.isNotEmpty) {
      final error = Validators.asciiValidator(pConfig.apiKey, 'API Key');
      if (error != null) _validationErrors['api_key'] = error;
    }

    // URL 校验
    final urlError = Validators.urlValidator(pConfig.baseUrl, 'Base URL');
    if (urlError != null) _validationErrors['base_url'] = urlError;

    // 模型列表校验
    final modelsError = Validators.nonEmptyModelsValidator(pConfig.models, provider);
    if (modelsError != null) _validationErrors['models'] = modelsError;

    // 参数校验
    final tempError = Validators.temperatureValidator(_config.parameters.temperature);
    if (tempError != null) _validationErrors['temperature'] = tempError;

    final maxTokensError = Validators.maxTokensValidator(_config.parameters.maxTokens);
    if (maxTokensError != null) _validationErrors['max_tokens'] = maxTokensError;

    notifyListeners();
    return _validationErrors.isEmpty;
  }

  Future<bool> save() async {
    if (!validate()) return false;
    await _repository.save(_config);
    _hasChanges = false;
    notifyListeners();
    return true;
  }
}
