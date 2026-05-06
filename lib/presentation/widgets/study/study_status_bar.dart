import 'package:fluent_ui/fluent_ui.dart';

class StudyStatusBar extends StatelessWidget {
  final int dueCount;
  final int totalCount;

  const StudyStatusBar({
    super.key,
    required this.dueCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.resources.cardBackgroundFillColorDefault,
        border: Border(
          top: BorderSide(color: theme.resources.cardStrokeColorDefault),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _StatusItem(
            icon: WindowsIcons.calendar_day,
            label: '到期卡片',
            value: dueCount.toString(),
          ),
          const SizedBox(width: 24),
          _StatusItem(
            icon: WindowsIcons.library,
            label: '总卡片数',
            value: totalCount.toString(),
          ),
        ],
      ),
    );
  }
}

class _StatusItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatusItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: theme.resources.textFillColorSecondary),
        const SizedBox(width: 6),
        Text(
          '$label: ',
          style: theme.typography.caption?.copyWith(
            color: theme.resources.textFillColorSecondary,
          ),
        ),
        Text(
          value,
          style: theme.typography.caption?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
