import 'package:flutter/material.dart';

import '../../components/buttons/elevated_button.dart';
import '../../components/buttons/outlined_button.dart';
import '../../components/dividers/horizontal_divider.dart';
import '../../constants/extensions/widget/padding_extension.dart';
import '../../constants/values_manager/font_manager.dart';
import '../../constants/values_manager/values_manager.dart';
import '../../helpers/localization/app_local.dart';
import '../../widgets/auth/o_auth/o_auth_list.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocal.tr(context, 'app.welcome_to_what_if'),
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: FontSize.s35,
                    ),
              ),
              Text(
                AppLocal.tr(
                  context,
                  'app.unlock_a_world_of_imagination_and_explore_limitless_possibilities',
                ),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: FontSize.s20,
                    ),
              ),
            ],
          ),
          const SizedBox(),
          const SizedBox(),
          const SizedBox(),
          Column(
            children: [
              Column(
                children: [
                  AppElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    },
                    child: Text(
                      AppLocal.tr(context, 'app.register'),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: AppSize.s18),
                  AppOutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                    child: Text(
                      AppLocal.tr(context, 'app.login'),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s18),
              Row(
                children: [
                  const Expanded(child: HorizontalDivider()),
                  Text(
                    AppLocal.tr(context, 'app.or').toUpperCase(),
                  ).padding([Edge.horizontal], AppPadding.p8),
                  const Expanded(child: HorizontalDivider()),
                ],
              ),
              const OAuthList(),
              const SizedBox(height: AppSize.s18),
            ],
          ),
        ],
      ).padding([Edge.horizontal], AppPadding.p18),
    );
  }
}
