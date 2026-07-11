import 'backup_service_stub.dart'
    if (dart.library.io) 'backup_service_io.dart'
    as implementation;

/// 备份业务逻辑服务
class BackupService {
  BackupService._();

  static bool get isSupported => implementation.isBackupSupported;

  /// 获取备份列表
  static Future<List<BackupInfo>> listBackups() async {
    return implementation.listBackups();
  }

  /// 创建手动备份
  static Future<String> createBackup() async {
    return implementation.createBackup();
  }

  /// 恢复备份
  static Future<void> restoreBackup(String path) async {
    await implementation.restoreBackup(path);
  }

  /// 删除备份
  static Future<void> deleteBackup(String path) async {
    await implementation.deleteBackup(path);
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
