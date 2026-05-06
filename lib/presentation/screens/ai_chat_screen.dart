import 'package:fluent_ui/fluent_ui.dart';

class AIChatScreen extends StatelessWidget {
  const AIChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('AI 助手')),
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const WindowsIcon(
              WindowsIcons.chat_bubbles,
              size: 48,
              color: Color(0xffffffff),
            ),
            const SizedBox(height: 16),
            Text(
              'AI Chat Screen',
              style: FluentTheme.of(context).typography.title,
            ),
          ],
        ),
      ),
    );
  }
}
