import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../providers/card_provider.dart';
import '../screens/study_screen.dart';
import '../screens/ai_chat_screen.dart';
import '../screens/card_manager_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/log_viewer_screen.dart';
import '../screens/backup_screen.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _selectedIndex = 0;
  final _searchController = TextEditingController();

  final List<NavigationPaneItem> _items = [
    PaneItem(
      icon: const WindowsIcon(WindowsIcons.dictionary, size: 18),
      title: const Text('学习'),
      body: const StudyScreen(),
    ),
    PaneItem(
      icon: const WindowsIcon(WindowsIcons.chat_bubbles, size: 18),
      title: const Text('AI 助手'),
      body: const AIChatScreen(),
    ),
    PaneItem(
      icon: const WindowsIcon(WindowsIcons.library, size: 18),
      title: const Text('卡片管理'),
      body: const CardManagerScreen(),
    ),
    PaneItem(
      icon: const WindowsIcon(WindowsIcons.report_document, size: 18),
      title: const Text('日志'),
      body: const LogViewerScreen(),
    ),
    PaneItem(
      icon: const WindowsIcon(WindowsIcons.save_local, size: 18),
      title: const Text('备份'),
      body: const BackupScreen(),
    ),
  ];

  final List<NavigationPaneItem> _footerItems = [
    PaneItem(
      icon: const WindowsIcon(WindowsIcons.settings, size: 18),
      title: const Text('设置'),
      body: const SettingsScreen(),
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile =
        defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;

    return SafeArea(
      child: NavigationView(
        titleBar: isMobile ? null : const TitleBar(title: Text('Papyrus')),
        transitionBuilder: (child, animation) {
          return EntrancePageTransition(animation: animation, child: child);
        },
        pane: NavigationPane(
          selected: _selectedIndex,
          onChanged: (index) => setState(() => _selectedIndex = index),
          displayMode: PaneDisplayMode.auto,
          indicator: const StickyNavigationIndicator(),
          items: _items,
          footerItems: _footerItems,
          autoSuggestBox: _buildSearchBox(),
          autoSuggestBoxReplacement: const Icon(WindowsIcons.search),
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Consumer<CardProvider>(
      builder: (context, provider, _) {
        final cards = provider.cards;
        final items = cards
            .map(
              (card) => AutoSuggestBoxItem(
                value: card.id,
                label: card.q,
                child: Text(
                  card.q,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onSelected: () {
                  _searchController.clear();
                  // 跳转到卡片管理页并搜索
                  setState(() => _selectedIndex = 2);
                  provider.search(card.q);
                },
              ),
            )
            .toList();

        return AutoSuggestBox<String>(
          controller: _searchController,
          items: items,
          placeholder: '搜索卡片...',
          trailingIcon: const Icon(WindowsIcons.search),
          onSelected: (item) {
            item.onSelected?.call();
          },
        );
      },
    );
  }
}
