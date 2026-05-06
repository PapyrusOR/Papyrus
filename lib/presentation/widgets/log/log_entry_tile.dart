import 'package:fluent_ui/fluent_ui.dart';
import '../../../data/models/log_entry_model.dart';

class LogEntryTile extends StatelessWidget {
  final LogEntryModel entry;

  const LogEntryTile({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final color = _getLevelColor(entry.level);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.resources.cardStrokeColorDefault.withValues(alpha: 0.5),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      entry.formattedTime,
                      style: theme.typography.caption?.copyWith(
                        color: theme.resources.textFillColorSecondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        entry.level.name.toUpperCase(),
                        style: theme.typography.caption?.copyWith(
                          color: color,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '[${entry.category.name}]',
                      style: theme.typography.caption?.copyWith(
                        color: theme.resources.textFillColorSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                SelectableText(
                  entry.message,
                  style: theme.typography.body,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getLevelColor(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return Colors.grey;
      case LogLevel.info:
        return Colors.green;
      case LogLevel.warning:
        return Colors.orange;
      case LogLevel.error:
        return Colors.red;
    }
  }
}
