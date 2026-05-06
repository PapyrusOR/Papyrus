import 'package:fluent_ui/fluent_ui.dart';
import '../../../data/models/ai_session_model.dart';

class ChatMessageList extends StatelessWidget {
  final List<MessageModel> messages;
  final String? streamingContent;

  const ChatMessageList({
    super.key,
    required this.messages,
    this.streamingContent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final displayMessages = List<MessageModel>.from(messages);
    
    // 如果正在流式输出，将当前流内容作为最后一条消息显示
    if (streamingContent != null && streamingContent!.isNotEmpty) {
      displayMessages.add(MessageModel(
        role: 'assistant',
        content: streamingContent!,
      ));
    }

    if (displayMessages.isEmpty) {
      return Center(
        child: Text(
          '开始与 AI 助手对话',
          style: theme.typography.body?.copyWith(
            color: theme.resources.textFillColorSecondary,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: displayMessages.length,
      itemBuilder: (context, index) {
        final message = displayMessages[index];
        final isUser = message.role == 'user';
        final isSystem = message.role == 'system';

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isUser)
                Container(
                  width: 32,
                  height: 32,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: isSystem
                        ? Colors.orange.lightest
                        : Colors.blue.lightest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    isSystem ? WindowsIcons.report_hacked : WindowsIcons.chat_bubbles,
                    size: 16,
                    color: isSystem ? Colors.orange : Colors.blue,
                  ),
                ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isUser
                        ? Colors.blue.lightest
                        : isSystem
                            ? Colors.orange.lightest.withValues(alpha: 0.3)
                            : theme.cardColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: theme.resources.cardStrokeColorDefault,
                    ),
                  ),
                  child: SelectableText(
                    message.content,
                    style: theme.typography.body,
                  ),
                ),
              ),
              if (isUser)
                Container(
                  width: 32,
                  height: 32,
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue.lightest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    WindowsIcons.contact,
                    size: 16,
                    color: Colors.blue,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
