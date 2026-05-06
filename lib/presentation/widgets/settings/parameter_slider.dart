import 'package:fluent_ui/fluent_ui.dart';

class ParameterSlider extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final double step;
  final ValueChanged<double>? onChanged;

  const ParameterSlider({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    this.step = 0.1,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(value.toStringAsFixed(step < 1 ? 1 : 0)),
          ],
        ),
        const SizedBox(height: 4),
        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
