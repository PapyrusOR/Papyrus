import 'package:fluent_ui/fluent_ui.dart';
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

  final List<NavigationPaneItem> _items = [
    PaneItem(
      icon: const WindowsIcon(
        WindowsIcons.dictionary,
        size: 18,
        color: Color(0xffffffff),
      ),
      title: const Text('学习'),
      body: const StudyScreen(),
    ),
    PaneItem(
      icon: const WindowsIcon(
        WindowsIcons.chat_bubbles,
        size: 18,
        color: Color(0xffffffff),
      ),
      title: const Text('AI 助手'),
      body: const AIChatScreen(),
    ),
    PaneItem(
      icon: const WindowsIcon(
        WindowsIcons.library,
        size: 18,
        color: Color(0xffffffff),
      ),
      title: const Text('卡片管理'),
      body: const CardManagerScreen(),
    ),
    PaneItem(
      icon: const WindowsIcon(
        WindowsIcons.report_document,
        size: 18,
        color: Color(0xffffffff),
      ),
      title: const Text('日志'),
      body: const LogViewerScreen(),
    ),
    PaneItem(
      icon: const WindowsIcon(
        WindowsIcons.save_local,
        size: 18,
        color: Color(0xffffffff),
      ),
      title: const Text('备份'),
      body: const BackupScreen(),
    ),
  ];

  final List<NavigationPaneItem> _footerItems = [
    PaneItem(
      icon: const WindowsIcon(
        WindowsIcons.settings,
        size: 18,
        color: Color(0xffffffff),
      ),
      title: const Text('设置'),
      body: const SettingsScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      titleBar: const TitleBar(
        title: Text('Papyrus'),
      ),
      transitionBuilder: (child, animation) {
        return EntrancePageTransition(
          animation: animation,
          child: child,
        );
      },
      pane: NavigationPane(
        selected: _selectedIndex,
        onChanged: (index) => setState(() => _selectedIndex = index),
        displayMode: PaneDisplayMode.compact,
        indicator: const StickyNavigationIndicator(),
        items: _items,
        footerItems: _footerItems,
      ),
    );
  }
}
