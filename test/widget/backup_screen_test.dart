import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:papyrus/presentation/screens/backup_screen.dart';

void main() {
  testWidgets('shows a clear fallback when backups are unsupported', (
    tester,
  ) async {
    await tester.pumpWidget(
      const FluentApp(home: BackupScreen(backupSupported: false)),
    );

    expect(find.text('当前平台不支持整库备份'), findsOneWidget);
    expect(find.text('学习、AI 和日志功能仍可正常使用。'), findsOneWidget);
    final createButton = tester.widget<IconButton>(
      find.byKey(const Key('backup-create-button')),
    );
    expect(createButton.onPressed, isNull);
  });
}
