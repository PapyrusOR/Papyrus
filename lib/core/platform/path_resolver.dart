import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../constants/app_constants.dart';

/// 跨平台数据目录路径解析
class PathResolver {
  PathResolver._();

  static Directory? _dataDir;

  /// 获取应用数据根目录
  static Future<Directory> get dataDir async {
    if (_dataDir != null) return _dataDir!;
    final dir = await getApplicationDocumentsDirectory();
    _dataDir = Directory(p.join(dir.path, AppConstants.appName));
    if (!await _dataDir!.exists()) {
      await _dataDir!.create(recursive: true);
    }
    return _dataDir!;
  }

  /// 获取备份目录
  static Future<Directory> get backupsDir async {
    final dir = await dataDir;
    final backupDir = Directory(p.join(dir.path, AppConstants.backupsDirName));
    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }
    return backupDir;
  }

  /// 获取附件目录
  static Future<Directory> attachmentsDir(String sessionUuid) async {
    final dir = await dataDir;
    final attachDir = Directory(
      p.join(dir.path, AppConstants.attachmentsDirName, sessionUuid),
    );
    if (!await attachDir.exists()) {
      await attachDir.create(recursive: true);
    }
    return attachDir;
  }

  /// 重置缓存（用于测试）
  static void reset() {
    _dataDir = null;
  }
}
