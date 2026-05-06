import 'package:fluent_ui/fluent_ui.dart';
import '../../../data/models/ai_session_model.dart';
import '../../widgets/common/confirm_dialog.dart';

class SessionSidebar extends StatelessWidget {
  final List<SessionModel> sessions;
  final String? activeSessionId;
  final ValueChanged<String>? onSwitchSession;
  final VoidCallback? onCreateSession;
  final ValueChanged<String>? onRenameSession;
  final ValueChanged<String>? onDeleteSession;

  const SessionSidebar({
    super.key,
    required this.sessions,
    this.activeSessionId,
    this.onSwitchSession,
    this.onCreateSession,
    this.onRenameSession,
    this.onDeleteSession,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Container(
      width: 240,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: theme.resources.cardStrokeColorDefault),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Button(
              onPressed: onCreateSession,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WindowsIcon(WindowsIcons.add, size: 16),
                  SizedBox(width: 6),
                  Text('新建会话'),
                ],
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                final isActive = session.id == activeSessionId;

                return ListTile.selectable(
                  selected: isActive,
                  onPressed: () => onSwitchSession?.call(session.id),
                  title: Text(
                    session.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${session.messageCount} 条消息',
                    style: theme.typography.caption,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const WindowsIcon(WindowsIcons.edit, size: 14),
                        onPressed: () => _showRenameDialog(context, session),
                      ),
                      if (sessions.length > 1)
                        IconButton(
                          icon: const WindowsIcon(WindowsIcons.delete, size: 14),
                          onPressed: () => _showDeleteDialog(context, session),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showRenameDialog(BuildContext context, SessionModel session) async {
    final controller = TextEditingController(text: session.title);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('重命名会话'),
        content: TextBox(
          controller: controller,
          placeholder: '会话名称',
          autofocus: true,
        ),
        actions: [
          Button(
            child: const Text('取消'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FilledButton(
            child: const Text('保存'),
            onPressed: () => Navigator.of(context).pop(controller.text.trim()),
          ),
        ],
      ),
    );
    controller.dispose();

    if (result != null && result.isNotEmpty) {
      onRenameSession?.call(result);
    }
  }

  Future<void> _showDeleteDialog(BuildContext context, SessionModel session) async {
    final confirmed = await showConfirmDialog(
      context: context,
      title: '删除会话',
      content: '确定要删除 "${session.title}" 吗？此操作不可恢复。',
    );
    if (confirmed) {
      onDeleteSession?.call(session.id);
    }
  }
}
