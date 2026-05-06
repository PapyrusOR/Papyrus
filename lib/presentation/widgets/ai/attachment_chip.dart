import 'package:fluent_ui/fluent_ui.dart';
import '../../../data/models/ai_session_model.dart';

class AttachmentChip extends StatelessWidget {
  final AttachmentModel attachment;
  final VoidCallback? onRemove;

  const AttachmentChip({
    super.key,
    required this.attachment,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isImage = attachment.type == 'image';

    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isImage ? Colors.blue.lightest : Colors.grey[30],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.resources.cardStrokeColorDefault,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isImage ? WindowsIcons.photo : WindowsIcons.document,
            size: 14,
            color: isImage ? Colors.blue : theme.resources.textFillColorSecondary,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              attachment.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.typography.caption,
            ),
          ),
          if (onRemove != null)
            IconButton(
              icon: const WindowsIcon(WindowsIcons.chrome_close, size: 12),
              onPressed: onRemove,
            ),
        ],
      ),
    );
  }
}
