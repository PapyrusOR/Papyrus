import '../data/local/app_database.dart';
import '../data/models/log_entry_model.dart';
import 'log_writers.dart';

/// 分级日志主类
class Logger {
  static Logger? _instance;
  static Logger get instance => _instance ??= Logger._internal();

  late final LogWriter _writer;

  Logger._internal();

  void initialize(AppDatabase db) {
    _writer = DriftLogWriter(db);
  }

  void debug(String message, {Map<String, dynamic>? metadata}) {
    _log(LogLevel.debug, LogCategory.main, message, metadata);
  }

  void info(String message, {Map<String, dynamic>? metadata}) {
    _log(LogLevel.info, LogCategory.main, message, metadata);
  }

  void warning(String message, {Map<String, dynamic>? metadata}) {
    _log(LogLevel.warning, LogCategory.main, message, metadata);
  }

  void error(String message, {Map<String, dynamic>? metadata}) {
    _log(LogLevel.error, LogCategory.main, message, metadata);
    // 错误同时写入 error 分类
    _log(LogLevel.error, LogCategory.error, message, metadata);
  }

  void activity(String action, {Map<String, dynamic>? metadata}) {
    _log(LogLevel.info, LogCategory.activity, action, metadata);
  }

  void event(String event, {Map<String, dynamic>? metadata}) {
    _log(LogLevel.info, LogCategory.events, event, metadata);
  }

  void _log(LogLevel level, LogCategory category, String message, Map<String, dynamic>? metadata) {
    final entry = LogEntryModel(
      timestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      level: level,
      category: category,
      message: message,
      metadata: metadata,
    );

    _writer.write(entry);
  }

  Future<void> clearAll() async {
    await _writer.clear();
  }
}
