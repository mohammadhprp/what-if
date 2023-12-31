import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../components/buttons/elevated_button.dart';
import '../../../components/error/error_screen.dart';
import '../../../components/loading/loading_screen.dart';
import '../../../components/rich_text/base_text.dart';
import '../../../components/rich_text/rich_text_widget.dart';
import '../../../components/text_field/email_text_field.dart';
import '../../../components/text_field/password_text_field.dart';
import '../../../constants/values_manager/font_manager.dart';
import '../../../constants/values_manager/values_manager.dart';
import '../../../helpers/localization/app_local.dart';
import '../../../screens/auth/register_screen.dart';
import '../../../screens/home/home_screen.dart';
import '../../../services/analytics_service.dart';
import '../../../state/backend/auth/authenticator.dart';
import '../../../state/providers/auth_providers/auth_state_provider.dart';
import '../../../utils/validator/value_validator.dart';

class LoginForm extends HookConsumerWidget {
  const LoginForm({super.key});

  Future<void> _login({
    required BuildContext context,
    required WidgetRef ref,
    required String email,
    required String password,
  }) async {
    final provider = ref.read(authStateProvider.notifier);

    // Show loading popup
    LoadingScreen.instance().show(
      context: context,
      text: AppLocal.tr(context, 'auth.loading'),
    );

    // Login user with email and password
    await provider
        .signIn(
      email: email,
      password: password,
    )
        .then((_) {
      // Track user login
      AnalyticsService.track(
        key: 'user',
        value: {'auth.login': const Authenticator().userId},
      );

      // Navigate to home screen
      Navigator.of(context).pushReplacementNamed(
        HomeScreen.routeName,
      );
    }).onError((error, stackTrace) {
      // Track user failed login
      AnalyticsService.track(
        key: 'user',
        value: {'auth.login.failed': 'Email: $email => $error'},
      );
      // Show an error popup
      ErrorScreen.instance().show(
        context: context,
        text: AppLocal.tr(context, "$error"),
      );
    }).whenComplete(() {
      // Hide loading popup
      LoadingScreen.instance().hide();
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final isEmailValid = useState(false);
    final isPasswordValid = useState(false);
    final isButtonEnabled = useState(false);

    useEffect(() {
      void listener() {
        // Validate email
        isEmailValid.value = emailController.text.trim().isNotEmpty &&
            ValueValidator.email(email: emailController.text);

        // Validate password
        isPasswordValid.value = passwordController.text.trim().isNotEmpty &&
            ValueValidator.password(password: passwordController.text);

        // Check name, email and password are valid
        isButtonEnabled.value = isEmailValid.value && isPasswordValid.value;
      }

      emailController.addListener(listener);
      passwordController.addListener(listener);

      return () {
        emailController.removeListener(listener);
        passwordController.removeListener(listener);
      };
    }, [emailController, passwordController]);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocal.tr(context, 'auth.welcome_back'),
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: FontSize.s30,
                    ),
              ),
              Text(
                AppLocal.tr(
                  context,
                  'auth.please_enter_your_email_and_password_to_login_in_your_account',
                ),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: FontSize.s20,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSize.s20),
        Column(
          children: [
            EmailTextField(
              hint: AppLocal.tr(context, 'form.enter_your_email'),
              controller: emailController,
            ),
            const SizedBox(height: AppSize.s18),
            PasswordTextField(
              hint: AppLocal.tr(context, 'form.enter_your_password'),
              controller: passwordController,
            ),
          ],
        ),
        const SizedBox(height: AppSize.s20),
        Column(
          children: [
            AppElevatedButton(
              onPressed: isButtonEnabled.value
                  ? () => _login(
                        context: context,
                        ref: ref,
                        email: emailController.text,
                        password: passwordController.text,
                      )
                  : null,
              child: Text(
                AppLocal.tr(context, 'button.login'),
              ),
            ),
            const SizedBox(height: AppSize.s20),
            RichTextWidget(
              styleForAll: Theme.of(context).textTheme.titleMedium,
              texts: [
                BaseText.plain(
                  text: AppLocal.tr(context, 'auth.do_not_have_an_account'),
                ),
                BaseText.link(
                  text: AppLocal.tr(context, 'button.register'),
                  onTapped: () {
                    Navigator.of(context).popAndPushNamed(
                      RegisterScreen.routeName,
                    );
                  },
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
