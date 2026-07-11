import 'dart:io';

import '../../data/local/backup_manager.dart';
import 'backup_service.dart';

const bool isBackupSupported = true;

Future<List<BackupInfo>> listBackups() async {
  final directories = await BackupManager.listBackups();
  return directories.map((directory) {
    final name = directory.uri.pathSegments
        .where((segment) => segment.isNotEmpty)
        .last;
    return BackupInfo(
      path: directory.path,
      name: name,
      isAuto: name.startsWith('auto_'),
      timestamp: _parseTimestamp(name),
    );
  }).toList();
}

Future<String> createBackup() => BackupManager.createManualBackup();

Future<void> restoreBackup(String path) =>
    BackupManager.restoreFromBackup(path);

Future<void> deleteBackup(String path) async {
  final directory = Directory(path);
  if (await directory.exists()) {
    await directory.delete(recursive: true);
  }
}

DateTime? _parseTimestamp(String name) {
  try {
    final parts = name.split('_');
    if (parts.length < 2) return null;
    final date = parts[1];
    final time = parts.length > 2 ? parts[2] : '000000';
    return DateTime(
      int.parse(date.substring(0, 4)),
      int.parse(date.substring(4, 6)),
      int.parse(date.substring(6, 8)),
      int.parse(time.substring(0, 2)),
      int.parse(time.substring(2, 4)),
      int.parse(time.substring(4, 6)),
    );
  } catch (_) {
    return null;
  }
}
