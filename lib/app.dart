import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'presentation/navigation/app_navigation.dart';

class PapyrusApp extends StatelessWidget {
  const PapyrusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
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
      supportedLocales: const [
        Locale('zh'),
        Locale('en'),
      ],
      home: const AppNavigation(),
    );
  }
}
