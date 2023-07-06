import 'package:flutter/material.dart';

import '../../screens/splash/splash_screen.dart';

@immutable
class AppRouter {
  static Map<String, Widget Function(BuildContext)> routes() => {
        SplashScreen.routeName: (context) => const SplashScreen(),
      };

  const AppRouter._();
}
