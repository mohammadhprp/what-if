import 'package:flutter/material.dart';

import '../../components/app_logo/app_logo.dart';
import '../../widgets/auth/auth_background.dart';
import '../../widgets/auth/login/login_form.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Expanded(flex: 1, child: AppLogo()),
          Spacer(),
          Expanded(
            flex: 3,
            child: AuthBackground(
              content: LoginForm(),
            ),
          ),
        ],
      ),
    );
  }
}
