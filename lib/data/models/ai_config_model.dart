import '../../core/constants/app_constants.dart';

class AIProviderConfig {
  final String? apiKey;
  final String baseUrl;
  final List<String> models;

  AIProviderConfig({
    this.apiKey,
    required this.baseUrl,
    this.models = const [],
  });

  factory AIProviderConfig.fromJson(Map<String, dynamic> json) {
    return AIProviderConfig(
      apiKey: json['api_key'] as String?,
      baseUrl: json['base_url'] as String? ?? '',
      models: (json['models'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'api_key': apiKey,
    'base_url': baseUrl,
    'models': models,
  };

  AIProviderConfig copyWith({
    String? apiKey,
    String? baseUrl,
    List<String>? models,
  }) {
    return AIProviderConfig(
      apiKey: apiKey ?? this.apiKey,
      baseUrl: baseUrl ?? this.baseUrl,
      models: models ?? this.models,
    );
  }
}

class AIParameters {
  final double temperature;
  final double topP;
  final int maxTokens;
  final double presencePenalty;
  final double frequencyPenalty;

  const AIParameters({
    this.temperature = AppConstants.defaultTemperature,
    this.topP = AppConstants.defaultTopP,
    this.maxTokens = AppConstants.defaultMaxTokens,
    this.presencePenalty = AppConstants.defaultPresencePenalty,
    this.frequencyPenalty = AppConstants.defaultFrequencyPenalty,
  });

  factory AIParameters.fromJson(Map<String, dynamic> json) {
    return AIParameters(
      temperature: (json['temperature'] as num?)?.toDouble() ?? AppConstants.defaultTemperature,
      topP: (json['top_p'] as num?)?.toDouble() ?? AppConstants.defaultTopP,
      maxTokens: (json['max_tokens'] as num?)?.toInt() ?? AppConstants.defaultMaxTokens,
      presencePenalty: (json['presence_penalty'] as num?)?.toDouble() ?? AppConstants.defaultPresencePenalty,
      frequencyPenalty: (json['frequency_penalty'] as num?)?.toDouble() ?? AppConstants.defaultFrequencyPenalty,
    );
  }

  Map<String, dynamic> toJson() => {
    'temperature': temperature,
    'top_p': topP,
    'max_tokens': maxTokens,
    'presence_penalty': presencePenalty,
    'frequency_penalty': frequencyPenalty,
  };

  AIParameters copyWith({
    double? temperature,
    double? topP,
    int? maxTokens,
    double? presencePenalty,
    double? frequencyPenalty,
  }) {
    return AIParameters(
      temperature: temperature ?? this.temperature,
      topP: topP ?? this.topP,
      maxTokens: maxTokens ?? this.maxTokens,
      presencePenalty: presencePenalty ?? this.presencePenalty,
      frequencyPenalty: frequencyPenalty ?? this.frequencyPenalty,
    );
  }
}

class AIFeatures {
  final bool autoHint;
  final bool autoExplain;
  final int contextLength;

  const AIFeatures({
    this.autoHint = false,
    this.autoExplain = false,
    this.contextLength = AppConstants.defaultContextLength,
  });

  factory AIFeatures.fromJson(Map<String, dynamic> json) {
    return AIFeatures(
      autoHint: json['auto_hint'] as bool? ?? false,
      autoExplain: json['auto_explain'] as bool? ?? false,
      contextLength: (json['context_length'] as num?)?.toInt() ?? AppConstants.defaultContextLength,
    );
  }

  Map<String, dynamic> toJson() => {
    'auto_hint': autoHint,
    'auto_explain': autoExplain,
    'context_length': contextLength,
  };

  AIFeatures copyWith({
    bool? autoHint,
    bool? autoExplain,
    int? contextLength,
  }) {
    return AIFeatures(
      autoHint: autoHint ?? this.autoHint,
      autoExplain: autoExplain ?? this.autoExplain,
      contextLength: contextLength ?? this.contextLength,
    );
  }
}

class AIConfigModel {
  final Map<String, AIProviderConfig> providers;
  final String? currentProvider;
  final String? currentModel;
  final AIParameters parameters;
  final AIFeatures features;

  AIConfigModel({
    this.providers = const {},
    this.currentProvider,
    this.currentModel,
    this.parameters = const AIParameters(),
    this.features = const AIFeatures(),
  });

  factory AIConfigModel.fromJson(Map<String, dynamic> json) {
    final providersRaw = json['providers'] as Map<String, dynamic>? ?? {};
    final providers = <String, AIProviderConfig>{};
    for (final entry in providersRaw.entries) {
      providers[entry.key] = AIProviderConfig.fromJson(entry.value as Map<String, dynamic>);
    }
    return AIConfigModel(
      providers: providers,
      currentProvider: json['current_provider'] as String?,
      currentModel: json['current_model'] as String?,
      parameters: AIParameters.fromJson(json['parameters'] as Map<String, dynamic>? ?? {}),
      features: AIFeatures.fromJson(json['features'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'providers': providers.map((k, v) => MapEntry(k, v.toJson())),
    'current_provider': currentProvider,
    'current_model': currentModel,
    'parameters': parameters.toJson(),
    'features': features.toJson(),
  };

  AIConfigModel copyWith({
    Map<String, AIProviderConfig>? providers,
    String? currentProvider,
    String? currentModel,
    AIParameters? parameters,
    AIFeatures? features,
  }) {
    return AIConfigModel(
      providers: providers ?? this.providers,
      currentProvider: currentProvider ?? this.currentProvider,
      currentModel: currentModel ?? this.currentModel,
      parameters: parameters ?? this.parameters,
      features: features ?? this.features,
    );
  }
}
