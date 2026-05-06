import 'package:fluent_ui/fluent_ui.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('设置')),
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const WindowsIcon(
              WindowsIcons.settings,
              size: 48,
              color: Color(0xffffffff),
            ),
            const SizedBox(height: 16),
            Text(
              'Settings Screen',
              style: FluentTheme.of(context).typography.title,
            ),
          ],
        ),
      ),
    );
  }
}
