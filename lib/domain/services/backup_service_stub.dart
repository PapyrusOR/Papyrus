import 'backup_service.dart';

const bool isBackupSupported = false;

Future<List<BackupInfo>> listBackups() async => const [];

Future<String> createBackup() => Future.error(
  UnsupportedError('Database backup is not available on this platform.'),
);

Future<void> restoreBackup(String path) => Future.error(
  UnsupportedError('Database restore is not available on this platform.'),
);

Future<void> deleteBackup(String path) => Future.error(
  UnsupportedError('Database backup is not available on this platform.'),
);
