import 'package:fluent_ui/fluent_ui.dart';

class BackupScreen extends StatelessWidget {
  const BackupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('备份')),
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const WindowsIcon(
              WindowsIcons.save_local,
              size: 48,
              color: Color(0xffffffff),
            ),
            const SizedBox(height: 16),
            Text(
              'Backup Screen',
              style: FluentTheme.of(context).typography.title,
            ),
          ],
        ),
      ),
    );
  }
}
