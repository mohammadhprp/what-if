import 'package:flutter/material.dart';

import '../../components/app_logo/app_logo.dart';
import '../../widgets/auth/auth_background.dart';
import '../../widgets/auth/register/register_form.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/auth/register';
  const RegisterScreen({super.key});

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
            flex: 4,
            child: AuthBackground(
              content: RegisterForm(),
            ),
          ),
        ],
      ),
    );
  }
}
