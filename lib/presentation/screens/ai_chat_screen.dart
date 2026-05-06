import 'package:flutter/material.dart' show Material;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import '../providers/ai_chat_provider.dart';
import '../providers/session_provider.dart';
import '../widgets/ai/chat_input_bar.dart';
import '../widgets/ai/chat_message_list.dart';
import '../widgets/ai/session_sidebar.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final _inputController = TextEditingController();
  bool _sidebarOpen = false;

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < 720;

    return Consumer2<AIChatProvider, SessionProvider>(
      builder: (context, chatProvider, sessionProvider, _) {
        if (!chatProvider.isAvailable) {
          return _buildUnavailableView(context);
        }

        return Stack(
          children: [
            Row(
              children: [
                if (!isNarrow)
                  SessionSidebar(
                    sessions: sessionProvider.sessions,
                    activeSessionId: sessionProvider.activeSession?.id,
                    onSwitchSession: (id) => sessionProvider.switchSession(id),
                    onCreateSession: () => sessionProvider.createSession(),
                    onRenameSession: (title) {
                      final session = sessionProvider.activeSession;
                      if (session != null) {
                        sessionProvider.renameSession(session.id, title);
                      }
                    },
                    onDeleteSession: (id) => sessionProvider.deleteSession(id),
                  ),
                Expanded(
                  child: Column(
                    children: [
                      _buildHeader(context, chatProvider, sessionProvider, isNarrow),
                      if (chatProvider.error != null)
                        InfoBar(
                          title: Text(chatProvider.error!),
                          severity: InfoBarSeverity.error,
                          onClose: () {},
                        ),
                      Expanded(
                        child: ChatMessageList(
                          messages: chatProvider.messages,
                          streamingContent: chatProvider.isStreaming
                              ? chatProvider.currentStreamContent
                              : null,
                        ),
                      ),
                      ChatInputBar(
                        controller: _inputController,
                        isLoading: chatProvider.isLoading,
                        onSend: () {
                          final text = _inputController.text;
                          chatProvider.sendMessage(text);
                          _inputController.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isNarrow && _sidebarOpen)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 260,
                child: Material(
                  color: FluentTheme.of(context).resources.solidBackgroundFillColorBase,
                  child: SessionSidebar(
                    sessions: sessionProvider.sessions,
                    activeSessionId: sessionProvider.activeSession?.id,
                    onSwitchSession: (id) {
                      sessionProvider.switchSession(id);
                      setState(() => _sidebarOpen = false);
                    },
                    onCreateSession: () => sessionProvider.createSession(),
                    onRenameSession: (title) {
                      final session = sessionProvider.activeSession;
                      if (session != null) {
                        sessionProvider.renameSession(session.id, title);
                      }
                    },
                    onDeleteSession: (id) => sessionProvider.deleteSession(id),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildHeader(
    BuildContext context,
    AIChatProvider provider,
    SessionProvider sessionProvider,
    bool isNarrow,
  ) {
    final sessionTitle = sessionProvider.activeSession?.title ?? '';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: FluentTheme.of(context).resources.cardStrokeColorDefault,
          ),
        ),
      ),
      child: Row(
        children: [
          if (isNarrow)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: const Icon(WindowsIcons.global_nav_button, size: 18),
                onPressed: () => setState(() => _sidebarOpen = !_sidebarOpen),
              ),
            ),
          Expanded(
            child: Text(
              isNarrow && sessionTitle.isNotEmpty ? sessionTitle : 'AI 助手',
              style: FluentTheme.of(context).typography.bodyLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ToggleSwitch(
            checked: provider.agentMode,
            onChanged: (_) => provider.toggleAgentMode(),
            content: const Text('Agent'),
          ),
        ],
      ),
    );
  }

  Widget _buildUnavailableView(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              WindowsIcons.info,
              size: 48,
              color: theme.resources.textFillColorSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'AI 助手未配置',
              style: theme.typography.title,
            ),
            const SizedBox(height: 8),
            Text(
              '请前往「设置」配置 AI 提供商和 API 密钥',
              textAlign: TextAlign.center,
              style: theme.typography.body?.copyWith(
                color: theme.resources.textFillColorSecondary,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {},
              child: const Text('前往设置'),
            ),
          ],
        ),
      ),
    );
  }
}
