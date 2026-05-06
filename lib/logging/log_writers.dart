import 'dart:convert';
import 'package:drift/drift.dart';
import '../data/local/app_database.dart';
import '../data/models/log_entry_model.dart';

/// 日志写入器接口
abstract class LogWriter {
  Future<void> write(LogEntryModel entry);
  Future<void> clear();
}

/// Drift 数据库日志写入器
class DriftLogWriter implements LogWriter {
  final AppDatabase _db;

  DriftLogWriter(this._db);

  @override
  Future<void> write(LogEntryModel entry) async {
    await _db.into(_db.logEntries).insert(LogEntriesCompanion(
          timestamp: Value(entry.timestamp),
          level: Value(entry.level.name),
          category: Value(entry.category.name),
          message: Value(entry.message),
          metadata: Value(entry.metadata != null ? jsonEncode(entry.metadata) : null),
        ));
  }

  @override
  Future<void> clear() async {
    await _db.delete(_db.logEntries).go();
  }
}
