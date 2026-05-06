import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../../core/platform/path_resolver.dart';
import '../providers/log_provider.dart';
import '../widgets/common/confirm_dialog.dart';
import '../widgets/log/log_entry_tile.dart';

class LogViewerScreen extends StatefulWidget {
  const LogViewerScreen({super.key});

  @override
  State<LogViewerScreen> createState() => _LogViewerScreenState();
}

class _LogViewerScreenState extends State<LogViewerScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LogProvider>().loadLogs();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < 600;

    return Consumer<LogProvider>(
      builder: (context, provider, _) {
        return ScaffoldPage(
          header: PageHeader(
            title: const Text('日志查看器'),
            commandBar: CommandBar(
              primaryItems: [
                CommandBarButton(
                  icon: const WindowsIcon(WindowsIcons.refresh, size: 16),
                  label: const Text('刷新'),
                  onPressed: () => provider.loadLogs(),
                ),
                CommandBarButton(
                  icon: const WindowsIcon(WindowsIcons.save, size: 16),
                  label: const Text('导出'),
                  onPressed: () => _exportLogs(context, provider),
                ),
                CommandBarButton(
                  icon: const WindowsIcon(WindowsIcons.delete, size: 16),
                  label: const Text('清空'),
                  onPressed: () => _clearLogs(context, provider),
                ),
              ],
            ),
          ),
          content: Column(
            children: [
              _buildFilterBar(context, provider, isNarrow),
              Expanded(
                child: provider.isLoading
                    ? const Center(child: ProgressRing())
                    : provider.entries.isEmpty
                        ? const Center(child: Text('暂无日志'))
                        : ListView.builder(
                            itemCount: provider.entries.length,
                            itemBuilder: (context, index) {
                              return LogEntryTile(entry: provider.entries[index]);
                            },
                          ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterBar(BuildContext context, LogProvider provider, bool isNarrow) {
    return Container(
      padding: EdgeInsets.all(isNarrow ? 12 : 16),
      child: isNarrow
          ? Column(
              children: [
                _buildSearchBox(provider),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: _buildTypeFilter(provider)),
                    const SizedBox(width: 8),
                    Expanded(child: _buildLimitFilter(provider)),
                  ],
                ),
              ],
            )
          : Row(
              children: [
                Expanded(child: _buildSearchBox(provider)),
                const SizedBox(width: 12),
                _buildTypeFilter(provider),
                const SizedBox(width: 12),
                _buildLimitFilter(provider),
              ],
            ),
    );
  }

  Widget _buildSearchBox(LogProvider provider) {
    return TextBox(
      controller: _searchController,
      placeholder: '搜索日志...',
      prefix: const Padding(
        padding: EdgeInsets.all(8),
        child: Icon(WindowsIcons.search, size: 16),
      ),
      onChanged: (value) => provider.setSearchQuery(value),
    );
  }

  Widget _buildTypeFilter(LogProvider provider) {
    return ComboBox<LogFilterType>(
      value: provider.filter,
      items: LogFilterType.values.map((type) {
        return ComboBoxItem(
          value: type,
          child: Text(switch (type) {
            LogFilterType.all => '全部',
            LogFilterType.error => '错误',
            LogFilterType.activity => '活动',
            LogFilterType.events => '事件',
          }),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) provider.setFilter(value);
      },
    );
  }

  Widget _buildLimitFilter(LogProvider provider) {
    return ComboBox<int>(
      value: provider.maxLines,
      items: [50, 100, 200, 500, 1000].map((n) {
        return ComboBoxItem(value: n, child: Text('$n 行'));
      }).toList(),
      onChanged: (value) {
        if (value != null) provider.setMaxLines(value);
      },
    );
  }

  Future<void> _exportLogs(BuildContext context, LogProvider provider) async {
    final now = DateTime.now();
    final fileName = 'logs_${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour}${now.minute}${now.second}.txt';
    final dataDir = await PathResolver.dataDir;
    final path = '${dataDir.path}/$fileName';
    await provider.exportLogs(path);
    if (context.mounted) {
      displayInfoBar(context, builder: (context, close) {
        return InfoBar(
          title: Text('日志已导出到: $path'),
          severity: InfoBarSeverity.success,
          onClose: close,
        );
      });
    }
  }

  Future<void> _clearLogs(BuildContext context, LogProvider provider) async {
    final confirmed = await showConfirmDialog(
      context: context,
      title: '清空日志',
      content: '确定要清空所有日志吗？此操作不可恢复。',
    );
    if (confirmed) {
      await provider.clearLogs();
    }
  }
}
