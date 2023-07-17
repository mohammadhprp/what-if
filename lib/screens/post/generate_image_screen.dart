import 'package:flutter/material.dart';

import '../../constants/extensions/theme/theme_extension.dart';
import '../../constants/extensions/widget/padding_extension.dart';
import '../../constants/values_manager/values_manager.dart';
import '../../helpers/localization/app_local.dart';
import '../../widgets/post/generate_image_form.dart';
import '../../widgets/post/generated_image.dart';

class GenerateImageScreen extends StatelessWidget {
  const GenerateImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.colorScheme.outlineVariant,
        title: Text(
          AppLocal.tr(context, 'app.add_post'),
          style: context.textTheme.displayLarge?.copyWith(
            color: context.theme.colorScheme.onBackground,
          ),
        ),
        toolbarHeight: AppSize.s80,
      ),
      body: const Column(
        children: [
          GenerateImageForm(),
          SizedBox(height: AppSize.s20),
          GeneratedImage(),
        ],
      ).padding([Edge.all], AppPadding.p12),
    );
  }
}
