import 'package:fluent_ui/fluent_ui.dart';

class GradeButtons extends StatelessWidget {
  final bool enabled;
  final VoidCallback? onForgot;
  final VoidCallback? onVague;
  final VoidCallback? onMastered;

  const GradeButtons({
    super.key,
    this.enabled = true,
    this.onForgot,
    this.onVague,
    this.onMastered,
  });

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < 600;

    final buttons = [
      _GradeButton(
        label: '忘记',
        hint: '1',
        color: Colors.red,
        onPressed: enabled ? onForgot : null,
        isNarrow: isNarrow,
      ),
      SizedBox(width: isNarrow ? 8 : 16),
      _GradeButton(
        label: '模糊',
        hint: '2',
        color: Colors.orange,
        onPressed: enabled ? onVague : null,
        isNarrow: isNarrow,
      ),
      SizedBox(width: isNarrow ? 8 : 16),
      _GradeButton(
        label: '秒杀',
        hint: '3',
        color: Colors.green,
        onPressed: enabled ? onMastered : null,
        isNarrow: isNarrow,
      ),
    ];

    if (isNarrow) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [buttons[0], buttons[1], buttons[2]]),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _HintBadge(color: Colors.red, hint: '1'),
              const SizedBox(width: 8),
              _HintBadge(color: Colors.orange, hint: '2'),
              const SizedBox(width: 8),
              _HintBadge(color: Colors.green, hint: '3'),
            ],
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttons,
    );
  }
}

class _GradeButton extends StatelessWidget {
  final String label;
  final String hint;
  final AccentColor color;
  final VoidCallback? onPressed;
  final bool isNarrow;

  const _GradeButton({
    required this.label,
    required this.hint,
    required this.color,
    this.onPressed,
    required this.isNarrow,
  });

  @override
  Widget build(BuildContext context) {
    final padding = isNarrow
        ? const EdgeInsets.symmetric(horizontal: 20, vertical: 14)
        : const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    final fontSize = isNarrow ? 14.0 : 16.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FilledButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(color),
            padding: WidgetStatePropertyAll(padding),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
          ),
        ),
        if (!isNarrow) ...[
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.lightest.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '按 $hint',
              style: FluentTheme.of(context).typography.caption?.copyWith(
                color: color,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _HintBadge extends StatelessWidget {
  final AccentColor color;
  final String hint;

  const _HintBadge({required this.color, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.lightest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '按 $hint',
        style: FluentTheme.of(context).typography.caption?.copyWith(color: color),
      ),
    );
  }
}
