import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../domain/services/backup_service.dart';
import '../providers/card_provider.dart';
import '../widgets/common/confirm_dialog.dart';

class BackupScreen extends StatefulWidget {
  final bool? backupSupported;

  const BackupScreen({super.key, this.backupSupported});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  List<BackupInfo> _backups = [];
  bool _isLoading = false;

  bool get _isBackupSupported =>
      widget.backupSupported ?? BackupService.isSupported;

  @override
  void initState() {
    super.initState();
    _loadBackups();
  }

  Future<void> _loadBackups() async {
    if (!_isBackupSupported) return;
    setState(() => _isLoading = true);
    _backups = await BackupService.listBackups();
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: const Text('备份与恢复'),
        commandBar: CommandBar(
          primaryItems: [
            CommandBarButton(
              key: const Key('backup-create-button'),
              icon: const WindowsIcon(WindowsIcons.save, size: 16),
              label: const Text('创建备份'),
              onPressed: _isBackupSupported ? _createBackup : null,
            ),
          ],
        ),
      ),
      content: !_isBackupSupported
          ? const Center(
              child: InfoBar(
                title: Text('当前平台不支持整库备份'),
                content: Text('学习、AI 和日志功能仍可正常使用。'),
                severity: InfoBarSeverity.info,
              ),
            )
          : _isLoading
          ? const Center(child: ProgressRing())
          : _backups.isEmpty
          ? const Center(child: Text('暂无备份'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _backups.length,
              itemBuilder: (context, index) {
                final backup = _backups[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(backup.name),
                    subtitle: backup.timestamp != null
                        ? Text('${backup.timestamp}')
                        : null,
                    leading: Icon(
                      backup.isAuto
                          ? WindowsIcons.calendar_day
                          : WindowsIcons.save_local,
                      size: 20,
                      color: backup.isAuto ? Colors.orange : Colors.blue,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Button(
                          onPressed: () => _restoreBackup(backup),
                          child: const Text('恢复'),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const WindowsIcon(
                            WindowsIcons.delete,
                            size: 16,
                          ),
                          onPressed: () => _deleteBackup(backup),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<void> _createBackup() async {
    setState(() => _isLoading = true);
    await BackupService.createBackup();
    await _loadBackups();
    if (mounted) {
      displayInfoBar(
        context,
        builder: (context, close) {
          return InfoBar(
            title: const Text('备份已创建'),
            severity: InfoBarSeverity.success,
            onClose: close,
          );
        },
      );
    }
  }

  Future<void> _restoreBackup(BackupInfo backup) async {
    final confirmed = await showConfirmDialog(
      context: context,
      title: '恢复备份',
      content: '恢复备份将覆盖当前所有数据。确定要继续吗？',
      confirmText: '恢复',
    );
    if (!confirmed || !mounted) return;

    setState(() => _isLoading = true);
    await BackupService.restoreBackup(backup.path);
    if (!mounted) return;
    await context.read<CardProvider>().loadCards();
    await _loadBackups();
    if (!mounted) return;
    setState(() => _isLoading = false);

    if (mounted) {
      displayInfoBar(
        context,
        builder: (context, close) {
          return InfoBar(
            title: const Text('备份已恢复'),
            severity: InfoBarSeverity.success,
            onClose: close,
          );
        },
      );
    }
  }

  Future<void> _deleteBackup(BackupInfo backup) async {
    final confirmed = await showConfirmDialog(
      context: context,
      title: '删除备份',
      content: '确定要删除 "${backup.name}" 吗？',
    );
    if (!confirmed) return;

    setState(() => _isLoading = true);
    await BackupService.deleteBackup(backup.path);
    await _loadBackups();
    if (mounted) setState(() => _isLoading = false);
  }
}
