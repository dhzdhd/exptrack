import 'package:exptrack/src/home/views/home_view.dart';
import 'package:exptrack/src/theme.dart';
import 'package:exptrack/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings/controllers/settings_controller.dart';
import 'settings/views/settings_view.dart';

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme =
        MaterialTheme(createTextTheme(context, 'Noto Sans', 'Noto Sans'));
    final settings = ref.watch(settingsProvider);

    return MaterialApp(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
      ],
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: settings.theme,
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) => switch (routeSettings.name) {
            SettingsView.routeName => const SettingsView(),
            HomeView.routeName => const HomeView(),
            _ => const HomeView(),
          },
        );
      },
    );
  }
}
