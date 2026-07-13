import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'data/local/app_database.dart';
import 'data/repositories/ai_config_repository_impl.dart';
import 'data/repositories/ai_session_repository_impl.dart';
import 'data/repositories/card_repository_impl.dart';
import 'logging/logger.dart';
import 'mcp/mcp_runtime.dart';
import 'presentation/navigation/app_navigation.dart';
import 'presentation/providers/ai_chat_provider.dart';
import 'presentation/providers/ai_config_provider.dart';
import 'presentation/providers/card_provider.dart';
import 'presentation/providers/log_provider.dart';
import 'presentation/providers/session_provider.dart';
import 'presentation/providers/study_provider.dart';

class PapyrusApp extends StatelessWidget {
  const PapyrusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<AppDatabase>(
      create: (_) => AppDatabase.defaults(),
      dispose: (_, db) => db.close(),
      child: _AppContent(),
    );
  }
}

class _AppContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    Logger.instance.initialize(db);

    return MultiProvider(
      providers: [
        // Repositories
        Provider<CardRepositoryImpl>(create: (_) => CardRepositoryImpl(db)),
        Provider<AIConfigRepositoryImpl>(
          create: (_) => AIConfigRepositoryImpl(db),
        ),
        Provider<AISessionRepositoryImpl>(
          create: (_) => AISessionRepositoryImpl(db),
        ),

        // Providers
        ChangeNotifierProvider<CardProvider>(
          create: (context) => CardProvider(context.read<CardRepositoryImpl>()),
        ),
        ChangeNotifierProvider<StudyProvider>(
          create: (context) =>
              StudyProvider(context.read<CardRepositoryImpl>()),
        ),
        ChangeNotifierProvider<SessionProvider>(
          create: (context) =>
              SessionProvider(context.read<AISessionRepositoryImpl>()),
        ),
        ChangeNotifierProvider<AIConfigProvider>(
          create: (context) =>
              AIConfigProvider(context.read<AIConfigRepositoryImpl>()),
        ),
        ChangeNotifierProvider<AIChatProvider>(
          create: (context) => AIChatProvider(
            context.read<AIConfigRepositoryImpl>(),
            context.read<CardRepositoryImpl>(),
            context.read<SessionProvider>(),
          ),
        ),
        ChangeNotifierProvider<LogProvider>(create: (_) => LogProvider(db)),
      ],
      child: _MCPServiceLifecycle(
        child: FluentApp(
          title: 'Papyrus',
          debugShowCheckedModeBanner: false,
          theme: FluentThemeData(
            accentColor: Colors.blue.toAccentColor(),
            visualDensity: VisualDensity.standard,
          ),
          darkTheme: FluentThemeData(
            brightness: Brightness.dark,
            accentColor: Colors.blue.toAccentColor(),
            visualDensity: VisualDensity.standard,
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            FluentLocalizations.delegate,
          ],
          supportedLocales: const [Locale('zh'), Locale('en')],
          home: const AppNavigation(),
        ),
      ),
    );
  }
}

class _MCPServiceLifecycle extends StatefulWidget {
  final Widget child;

  const _MCPServiceLifecycle({required this.child});

  @override
  State<_MCPServiceLifecycle> createState() => _MCPServiceLifecycleState();
}

class _MCPServiceLifecycleState extends State<_MCPServiceLifecycle> {
  @override
  void initState() {
    super.initState();
    unawaited(_startService());
  }

  Future<void> _startService() async {
    try {
      await startMCPService();
    } catch (error) {
      Logger.instance.error(
        'MCP server failed to start',
        metadata: {'error': error.toString()},
      );
    }
  }

  @override
  void dispose() {
    unawaited(stopMCPService());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
