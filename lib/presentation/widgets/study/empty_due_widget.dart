import 'package:fluent_ui/fluent_ui.dart';

class EmptyDueWidget extends StatelessWidget {
  final VoidCallback? onRefresh;
  final bool hasCards;

  const EmptyDueWidget({super.key, this.onRefresh, this.hasCards = true});

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            hasCards ? WindowsIcons.check_mark : WindowsIcons.library,
            size: 64,
            color: theme.resources.textFillColorSecondary,
          ),
          const SizedBox(height: 16),
          if (!hasCards) Text('暂无卡片', style: theme.typography.title),
          if (hasCards) Text('今日任务已完成', style: theme.typography.title),
          const SizedBox(height: 8),
          if (!hasCards)
            Text(
              '请先添加或导入卡片开始学习',
              style: theme.typography.caption?.copyWith(
                color: theme.resources.textFillColorSecondary,
              ),
            ),
          if (hasCards)
            Text(
              '系统会定期检查是否有新到期的卡片',
              style: theme.typography.caption?.copyWith(
                color: theme.resources.textFillColorSecondary,
              ),
            ),
          const SizedBox(height: 16),
          if (onRefresh != null)
            Button(onPressed: onRefresh, child: const Text('立即检查')),
        ],
      ),
    );
  }
}
