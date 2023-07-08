import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../constants/app/app_router.dart';
import '../constants/app/app_theme.dart';
import '../helpers/localization/app_localizations.dart';
import '../screens/splash/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'What If?',
      theme: AppTheme.dark(),
      routes: AppRouter.routes(),
      home: const SplashScreen(),
      navigatorKey: navigatorKey,
      supportedLocales: AppLocalizations.locales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        return locale != null && AppLocalizations.isSupported(locale)
            ? locale
            : supportedLocales.first;
      },
    );
  }
}
