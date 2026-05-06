import '../core/extensions/string_extensions.dart';

/// 日志敏感字段掩码处理器
class Sanitizers {
  Sanitizers._();

  /// 对 Map 中的敏感字段进行掩码处理
  static Map<String, dynamic> sanitizeMap(Map<String, dynamic> map) {
    final result = <String, dynamic>{};
    for (final entry in map.entries) {
      result[entry.key] = _sanitizeValue(entry.key, entry.value);
    }
    return result;
  }

  static dynamic _sanitizeValue(String key, dynamic value) {
    if (key.isSensitiveKey && value is String) {
      return value.masked;
    }
    if (value is Map<String, dynamic>) {
      return sanitizeMap(value);
    }
    if (value is List) {
      return value.map((item) {
        if (item is Map<String, dynamic>) return sanitizeMap(item);
        return item;
      }).toList();
    }
    if (value is String && value.length > 800) {
      return value.truncate(800);
    }
    return value;
  }

  /// 对纯文本日志中的敏感信息进行掩码
  static String sanitizeText(String text) {
    var result = text;
    final sensitiveKeys = ['api_key', 'authorization', 'token', 'secret', 'password', 'key'];

    for (final key in sensitiveKeys) {
      // 匹配 key="value" 或 key='value' 或 key=value
      final pattern = RegExp(
        '($key\\s*[:=]\\s*)(["\x27])([^"\x27]*)(\\2)',
        caseSensitive: false,
      );
      result = result.replaceAllMapped(pattern, (match) {
        final prefix = match.group(1) ?? '';
        final quote = match.group(2) ?? '';
        final value = match.group(3) ?? '';
        return '$prefix$quote${value.masked}$quote';
      });
    }

    return result;
  }
}
