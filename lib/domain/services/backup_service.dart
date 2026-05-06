import 'dart:io';
import '../../data/local/backup_manager.dart';

/// 备份业务逻辑服务
class BackupService {
  BackupService._();

  /// 获取备份列表
  static Future<List<BackupInfo>> listBackups() async {
    final dirs = await BackupManager.listBackups();
    return dirs.map((dir) {
      final name = dir.path.split('/').last;
      final isAuto = name.startsWith('auto_');
      final timestamp = _parseTimestamp(name);
      return BackupInfo(
        path: dir.path,
        name: name,
        isAuto: isAuto,
        timestamp: timestamp,
      );
    }).toList();
  }

  /// 创建手动备份
  static Future<String> createBackup() async {
    return BackupManager.createManualBackup();
  }

  /// 恢复备份
  static Future<void> restoreBackup(String path) async {
    await BackupManager.restoreFromBackup(path);
  }

  /// 删除备份
  static Future<void> deleteBackup(String path) async {
    final dir = Directory(path);
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }

  static DateTime? _parseTimestamp(String name) {
    try {
      final parts = name.split('_');
      if (parts.length < 2) return null;
      final dateStr = parts[1];
      final timeStr = parts.length > 2 ? parts[2] : '000000';
      return DateTime(
        int.parse(dateStr.substring(0, 4)),
        int.parse(dateStr.substring(4, 6)),
        int.parse(dateStr.substring(6, 8)),
        int.parse(timeStr.substring(0, 2)),
        int.parse(timeStr.substring(2, 4)),
        int.parse(timeStr.substring(4, 6)),
      );
    } catch (_) {
      return null;
    }
  }
}

class BackupInfo {
  final String path;
  final String name;
  final bool isAuto;
  final DateTime? timestamp;

  BackupInfo({
    required this.path,
    required this.name,
    required this.isAuto,
    this.timestamp,
  });
}
