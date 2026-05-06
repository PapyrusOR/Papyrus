import 'package:fluent_ui/fluent_ui.dart';

class EmptyDueWidget extends StatelessWidget {
  final VoidCallback? onRefresh;

  const EmptyDueWidget({super.key, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            WindowsIcons.check_mark,
            size: 64,
            color: theme.resources.textFillColorSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            '今日任务已完成',
            style: theme.typography.title,
          ),
          const SizedBox(height: 8),
          Text(
            '系统会定期检查是否有新到期的卡片',
            style: theme.typography.caption?.copyWith(
              color: theme.resources.textFillColorSecondary,
            ),
          ),
          const SizedBox(height: 16),
          if (onRefresh != null)
            Button(
              onPressed: onRefresh,
              child: const Text('立即检查'),
            ),
        ],
      ),
    );
  }
}
