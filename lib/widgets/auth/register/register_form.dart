import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../components/buttons/elevated_button.dart';
import '../../../components/error/error_screen.dart';
import '../../../components/loading/loading_screen.dart';
import '../../../components/rich_text/base_text.dart';
import '../../../components/rich_text/rich_text_widget.dart';
import '../../../components/text_field/context_text_field.dart';
import '../../../components/text_field/email_text_field.dart';
import '../../../components/text_field/password_text_field.dart';
import '../../../constants/values_manager/font_manager.dart';
import '../../../constants/values_manager/values_manager.dart';
import '../../../helpers/localization/app_local.dart';
import '../../../screens/auth/login_screen.dart';
import '../../../screens/home/home_screen.dart';
import '../../../services/analytics_service.dart';
import '../../../state/backend/auth/authenticator.dart';
import '../../../state/providers/auth_providers/auth_state_provider.dart';
import '../../../utils/validator/value_validator.dart';

class RegisterForm extends HookConsumerWidget {
  const RegisterForm({super.key});

  Future<void> _register({
    required BuildContext context,
    required WidgetRef ref,
    required String email,
    required String password,
    required String name,
  }) async {
    final provider = ref.read(authStateProvider.notifier);

    // Show loading popup
    LoadingScreen.instance().show(
      context: context,
      text: AppLocal.tr(context, 'app.loading'),
    );

    // Register user with email and password
    await provider
        .signUp(email: email, password: password, name: name)
        .then((_) {
      // Track new user register,
      AnalyticsService.track(
        key: 'user',
        value: {'auth.register': const Authenticator().userId},
      );

      // Navigate to home screen
      Navigator.of(context).pushReplacementNamed(
        HomeScreen.routeName,
      );
    }).onError((error, stackTrace) {
      // Track user failed register
      AnalyticsService.track(
        key: 'user',
        value: {'auth.register.failed': 'Email: $email,password: $password'},
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
    final nameController = useTextEditingController();
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
        isButtonEnabled.value = isEmailValid.value &&
            isPasswordValid.value &&
            nameController.text.trim().isNotEmpty;
      }

      nameController.addListener(listener);
      emailController.addListener(listener);
      passwordController.addListener(listener);

      return () {
        nameController.removeListener(listener);
        emailController.removeListener(listener);
        passwordController.removeListener(listener);
      };
    }, [nameController, emailController, passwordController]);
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
                AppLocal.tr(context, 'app.create_new_account'),
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: FontSize.s30,
                    ),
              ),
              Text(
                AppLocal.tr(context, 'app.please_enter_info_to_create_account'),
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
            ContextTextField(
              hint: AppLocal.tr(context, 'app.enter_your_name'),
              controller: nameController,
            ),
            const SizedBox(height: AppSize.s18),
            EmailTextField(
              hint: AppLocal.tr(context, 'app.enter_your_email'),
              controller: emailController,
            ),
            const SizedBox(height: AppSize.s18),
            PasswordTextField(
              hint: AppLocal.tr(context, 'app.enter_your_password'),
              controller: passwordController,
            ),
          ],
        ),
        const SizedBox(height: AppSize.s20),
        Column(
          children: [
            AppElevatedButton(
              onPressed: isButtonEnabled.value
                  ? () => _register(
                        context: context,
                        ref: ref,
                        email: emailController.text,
                        password: passwordController.text,
                        name: nameController.text,
                      )
                  : null,
              child: Text(
                AppLocal.tr(context, 'app.register'),
              ),
            ),
            const SizedBox(height: AppSize.s20),
            RichTextWidget(
              styleForAll: Theme.of(context).textTheme.titleMedium,
              texts: [
                BaseText.plain(
                  text: AppLocal.tr(context, 'app.already_have_an_account'),
                ),
                BaseText.link(
                  text: AppLocal.tr(context, 'app.login'),
                  onTapped: () {
                    Navigator.of(context).popAndPushNamed(
                      LoginScreen.routeName,
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
