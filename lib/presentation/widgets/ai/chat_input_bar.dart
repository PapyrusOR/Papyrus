import 'package:fluent_ui/fluent_ui.dart';

class ChatInputBar extends StatefulWidget {
  final bool isLoading;
  final VoidCallback? onSend;
  final ValueChanged<String>? onTextChanged;
  final TextEditingController? controller;

  const ChatInputBar({
    super.key,
    this.isLoading = false,
    this.onSend,
    this.onTextChanged,
    this.controller,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty && !widget.isLoading) {
      widget.onSend?.call();
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.resources.cardBackgroundFillColorDefault,
        border: Border(
          top: BorderSide(color: theme.resources.cardStrokeColorDefault),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextBox(
              controller: _controller,
              placeholder: '输入消息... (Shift+Enter 换行)',
              maxLines: 5,
              minLines: 1,
              onSubmitted: (_) => _handleSend(),
            ),
          ),
          const SizedBox(width: 8),
          if (widget.isLoading)
            const SizedBox(
              width: 32,
              height: 32,
              child: ProgressRing(strokeWidth: 2),
            )
          else
            IconButton(
              icon: const WindowsIcon(WindowsIcons.send, size: 18),
              onPressed: _handleSend,
            ),
        ],
      ),
    );
  }
}
