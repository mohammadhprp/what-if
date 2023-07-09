import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../components/buttons/elevated_button.dart';
import '../../../components/rich_text/base_text.dart';
import '../../../components/rich_text/rich_text_widget.dart';
import '../../../components/text_field/email_text_field.dart';
import '../../../components/text_field/password_text_field.dart';
import '../../../constants/values_manager/font_manager.dart';
import '../../../constants/values_manager/values_manager.dart';
import '../../../helpers/localization/app_local.dart';
import '../../../screens/auth/register_screen.dart';
import '../../../utils/validator/value_validator.dart';

class LoginForm extends HookConsumerWidget {
  const LoginForm({super.key});

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
                AppLocal.tr(context, 'app.welcome_back'),
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: FontSize.s30,
                    ),
              ),
              Text(
                AppLocal.tr(
                  context,
                  'app.please_enter_your_email_and_password_to_login_in_your_account',
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
                  ? () {
                      // TODO: Login user
                    }
                  : null,
              child: Text(
                AppLocal.tr(context, 'app.login'),
              ),
            ),
            const SizedBox(height: AppSize.s20),
            RichTextWidget(
              styleForAll: Theme.of(context).textTheme.titleMedium,
              texts: [
                BaseText.plain(
                  text: AppLocal.tr(context, 'app.do_not_have_an_account'),
                ),
                BaseText.link(
                  text: AppLocal.tr(context, 'app.register'),
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
