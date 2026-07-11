import 'package:flutter/material.dart';
import '../../core/platform/log_export.dart';
import '../../data/local/app_database.dart';
import '../../data/models/log_entry_model.dart';

enum LogFilterType { all, error, activity, events }

class LogProvider extends ChangeNotifier {
  final AppDatabase _db;

  LogProvider(this._db) {
    loadLogs();
  }

  List<LogEntryModel> _entries = [];
  LogFilterType _filter = LogFilterType.all;
  String _searchQuery = '';
  int _maxLines = 200;
  bool _isLoading = false;

  List<LogEntryModel> get entries => _filteredEntries;
  LogFilterType get filter => _filter;
  String get searchQuery => _searchQuery;
  int get maxLines => _maxLines;
  bool get isLoading => _isLoading;

  List<LogEntryModel> get _filteredEntries {
    var result = List<LogEntryModel>.from(_entries);

    if (_filter != LogFilterType.all) {
      final category = LogCategory.values[_filter.index - 1];
      result = result.where((e) => e.category == category).toList();
    }

    if (_searchQuery.isNotEmpty) {
      final lower = _searchQuery.toLowerCase();
      result = result.where((e) {
        return e.message.toLowerCase().contains(lower) ||
            e.level.name.toLowerCase().contains(lower);
      }).toList();
    }

    if (result.length > _maxLines) {
      result = result.sublist(result.length - _maxLines);
    }

    return result;
  }

  Future<void> loadLogs() async {
    _isLoading = true;
    notifyListeners();

    final rows = await _db.select(_db.logEntries).get();
    _entries = rows
        .map(
          (r) => LogEntryModel(
            timestamp: r.timestamp,
            level: LogLevel.values.byName(r.level),
            category: LogCategory.values.byName(r.category),
            message: r.message,
            metadata: null,
          ),
        )
        .toList();

    _isLoading = false;
    notifyListeners();
  }

  void setFilter(LogFilterType filter) {
    _filter = filter;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setMaxLines(int lines) {
    _maxLines = lines;
    notifyListeners();
  }

  Future<String> exportLogs(String fileName) async {
    final rows = await _db.select(_db.logEntries).get();
    final entries = rows.map((row) {
      return LogEntryModel(
        timestamp: row.timestamp,
        level: LogLevel.values.byName(row.level),
        category: LogCategory.values.byName(row.category),
        message: row.message,
        metadata: null,
      );
    });
    return exportLogText(fileName, formatLogEntries(entries));
  }

  static String formatLogEntries(Iterable<LogEntryModel> entries) {
    final buffer = StringBuffer();
    for (final entry in entries) {
      buffer.writeln(entry.toPlainText());
    }
    return buffer.toString();
  }

  Future<void> clearLogs() async {
    await _db.delete(_db.logEntries).go();
    _entries = [];
    notifyListeners();
  }
}
