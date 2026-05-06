import 'package:fluent_ui/fluent_ui.dart';

class CardFaceWidget extends StatelessWidget {
  final String title;
  final String content;
  final bool isAnswer;

  const CardFaceWidget({
    super.key,
    required this.title,
    required this.content,
    this.isAnswer = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isNarrow = MediaQuery.sizeOf(context).width < 600;
    final padding = isNarrow ? const EdgeInsets.all(20) : const EdgeInsets.all(32);
    final fontSize = isNarrow ? 20.0 : 24.0;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 720),
      padding: padding,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.resources.cardStrokeColorDefault,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.typography.caption?.copyWith(
              color: theme.resources.textFillColorSecondary,
            ),
          ),
          const SizedBox(height: 12),
          SelectableText(
            content,
            style: theme.typography.titleLarge?.copyWith(
              fontSize: fontSize,
              height: 1.5,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
