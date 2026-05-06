import 'package:fluent_ui/fluent_ui.dart';

Future<bool> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  String confirmText = '确认',
  String cancelText = '取消',
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => ContentDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        Button(
          child: Text(cancelText),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        FilledButton(
          child: Text(confirmText),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
  return result ?? false;
}
