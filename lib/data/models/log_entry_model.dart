enum LogLevel { debug, info, warning, error }

enum LogCategory { main, error, activity, events }

class LogEntryModel {
  final int timestamp;
  final LogLevel level;
  final LogCategory category;
  final String message;
  final Map<String, dynamic>? metadata;

  LogEntryModel({
    required this.timestamp,
    required this.level,
    required this.category,
    required this.message,
    this.metadata,
  });

  factory LogEntryModel.fromJson(Map<String, dynamic> json) {
    return LogEntryModel(
      timestamp: (json['timestamp'] as num?)?.toInt() ?? 0,
      level: LogLevel.values.byName(json['level'] as String? ?? 'info'),
      category: LogCategory.values.byName(json['category'] as String? ?? 'main'),
      message: json['message'] as String? ?? '',
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp,
    'level': level.name,
    'category': category.name,
    'message': message,
    if (metadata != null) 'metadata': metadata,
  };

  String get formattedTime {
    final dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';
  }

  String toPlainText() {
    return '[$formattedTime] [${level.name.toUpperCase()}] [$category] $message';
  }

  String toJsonl() {
    return '{"timestamp":$timestamp,"level":"${level.name}","category":"${category.name}","message":"${_escapeJson(message)}"${metadata != null ? ',"metadata":$metadata' : ''}}';
  }

  static String _escapeJson(String s) {
    return s
        .replaceAll('\\', '\\\\')
        .replaceAll('"', '\\"')
        .replaceAll('\n', '\\n')
        .replaceAll('\r', '\\r')
        .replaceAll('\t', '\\t');
  }
}
