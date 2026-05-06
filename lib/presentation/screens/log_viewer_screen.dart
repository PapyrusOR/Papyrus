import 'package:fluent_ui/fluent_ui.dart';

class LogViewerScreen extends StatelessWidget {
  const LogViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('日志')),
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const WindowsIcon(
              WindowsIcons.report_document,
              size: 48,
              color: Color(0xffffffff),
            ),
            const SizedBox(height: 16),
            Text(
              'Log Viewer Screen',
              style: FluentTheme.of(context).typography.title,
            ),
          ],
        ),
      ),
    );
  }
}
