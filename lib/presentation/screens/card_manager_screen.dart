import 'package:fluent_ui/fluent_ui.dart';

class CardManagerScreen extends StatelessWidget {
  const CardManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('卡片管理')),
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const WindowsIcon(
              WindowsIcons.library,
              size: 48,
              color: Color(0xffffffff),
            ),
            const SizedBox(height: 16),
            Text(
              'Card Manager Screen',
              style: FluentTheme.of(context).typography.title,
            ),
          ],
        ),
      ),
    );
  }
}
