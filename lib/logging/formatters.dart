import 'dart:convert';
import '../data/models/log_entry_model.dart';
import 'sanitizers.dart';

/// 日志格式化器
class Formatters {
  Formatters._();

  /// 格式化为纯文本行
  static String toPlainText(LogEntryModel entry) {
    final sanitized = entry.metadata != null
        ? Sanitizers.sanitizeMap(entry.metadata!)
        : null;
    
    var text = entry.toPlainText();
    if (sanitized != null && sanitized.isNotEmpty) {
      text += ' | ${sanitized.toString()}';
    }
    return Sanitizers.sanitizeText(text);
  }

  /// 格式化为 JSONL 行
  static String toJsonl(LogEntryModel entry) {
    final sanitized = entry.metadata != null
        ? Sanitizers.sanitizeMap(entry.metadata!)
        : null;

    final map = <String, dynamic>{
      'timestamp': entry.timestamp,
      'level': entry.level.name,
      'category': entry.category.name,
      'message': entry.message,
    };

    if (sanitized != null) {
      map['metadata'] = sanitized;
    }

    return jsonEncode(map);
  }
}
