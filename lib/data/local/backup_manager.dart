import 'dart:io';
import 'package:path/path.dart' as p;
import '../../core/constants/app_constants.dart';
import '../../core/platform/path_resolver.dart';

/// 备份管理器：自动/手动备份与恢复
class BackupManager {
  BackupManager._();

  static DateTime? _lastAutoBackupTime;

  static Future<String> _dbPath() async {
    final dir = await PathResolver.dataDir;
    return p.join(dir.path, 'papyrus_db.sqlite');
  }

  /// 获取所有备份目录列表（按时间倒序）
  static Future<List<Directory>> listBackups() async {
    final backupsDir = await PathResolver.backupsDir;
    final entries = await backupsDir.list().toList();
    final dirs = entries.whereType<Directory>().toList();
    dirs.sort((a, b) => b.path.compareTo(a.path));
    return dirs;
  }

  /// 创建手动备份
  static Future<String> createManualBackup() async {
    final timestamp = _formatTimestamp(DateTime.now());
    final backupDir = await _createBackupDir('manual_$timestamp');
    await _copyDbFile(backupDir);
    return backupDir.path;
  }

  /// 检查并执行自动备份
  static Future<void> checkAutoBackup() async {
    final now = DateTime.now();
    if (_lastAutoBackupTime != null &&
        now.difference(_lastAutoBackupTime!) < AppConstants.autoBackupInterval) {
      return;
    }

    final timestamp = _formatTimestamp(now);
    final backupDir = await _createBackupDir('auto_$timestamp');
    await _copyDbFile(backupDir);
    _lastAutoBackupTime = now;
  }

  /// 从备份恢复
  static Future<void> restoreFromBackup(String backupPath) async {
    final backupDir = Directory(backupPath);
    if (!await backupDir.exists()) {
      throw Exception('备份目录不存在: $backupPath');
    }

    final dbFile = File(p.join(backupPath, 'papyrus_db.sqlite'));
    if (!await dbFile.exists()) {
      throw Exception('备份文件不存在');
    }

    final targetPath = await _dbPath();
    final targetFile = File(targetPath);
    await targetFile.parent.create(recursive: true);
    await dbFile.copy(targetPath);
  }

  /// 危险操作前强制创建备份
  static Future<String> createPreOperationBackup() async {
    return createManualBackup();
  }

  static Future<Directory> _createBackupDir(String name) async {
    final backupsDir = await PathResolver.backupsDir;
    final dir = Directory(p.join(backupsDir.path, name));
    await dir.create(recursive: true);
    return dir;
  }

  static Future<void> _copyDbFile(Directory backupDir) async {
    final dbPath = await _dbPath();
    final dbFile = File(dbPath);
    if (await dbFile.exists()) {
      final dest = File(p.join(backupDir.path, 'papyrus_db.sqlite'));
      await dbFile.copy(dest.path);
    }
  }

  static String _formatTimestamp(DateTime dt) {
    return '${dt.year}${_pad(dt.month)}${_pad(dt.day)}_${_pad(dt.hour)}${_pad(dt.minute)}${_pad(dt.second)}';
  }

  static String _pad(int n) => n.toString().padLeft(2, '0');
}
