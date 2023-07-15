import 'package:flutter/material.dart';

import '../../screens/auth/auth_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/register_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/main/main_screen.dart';
import '../../screens/splash/splash_screen.dart';

@immutable
class AppRouter {
  static Map<String, Widget Function(BuildContext)> routes() => {
        SplashScreen.routeName: (context) => const SplashScreen(),
        AuthScreen.routeName: (context) => const AuthScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        MainScreen.routeName: (context) => const MainScreen(),
      };

  const AppRouter._();
}
