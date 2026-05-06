import '../extensions/string_extensions.dart';

/// 配置校验工具
class Validators {
  Validators._();

  /// 验证字符串是否为纯 ASCII（用于 API Key / Base URL）
  static String? asciiValidator(String? value, String fieldName) {
    if (value == null || value.isEmpty) return null;
    if (!value.isAscii) {
      return '$fieldName 包含非 ASCII 字符（如中文、特殊空格），请检查输入';
    }
    return null;
  }

  /// 验证 URL 格式（基础校验）
  static String? urlValidator(String? value, String fieldName) {
    if (value == null || value.isEmpty) return null;
    final uri = Uri.tryParse(value);
    if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
      return '$fieldName 不是有效的 URL 格式';
    }
    return null;
  }

  /// 验证模型列表非空
  static String? nonEmptyModelsValidator(List<String> models, String providerName) {
    if (models.isEmpty) {
      return '$providerName 至少需要保留一个模型';
    }
    return null;
  }

  /// 验证温度范围
  static String? temperatureValidator(double value) {
    if (value < 0 || value > 2) {
      return 'Temperature 必须在 0~2 之间';
    }
    return null;
  }

  /// 验证 Max Tokens 范围
  static String? maxTokensValidator(int value) {
    if (value < 100 || value > 4000) {
      return 'Max Tokens 必须在 100~4000 之间';
    }
    return null;
  }
}
