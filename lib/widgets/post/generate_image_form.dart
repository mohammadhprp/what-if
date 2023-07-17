import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/buttons/icon_button.dart';
import '../../components/icon/icon_view.dart';
import '../../components/text_field/prompt_box_field.dart';
import '../../constants/app/app_icons.dart';
import '../../helpers/localization/app_local.dart';
import '../../state/providers/post_providers/generate_image_provider.dart';

class GenerateImageForm extends HookConsumerWidget {
  const GenerateImageForm({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: 'cute cat');

    return Row(
      children: [
        Expanded(
          flex: 4,
          child: PromptBoxField(
            controller: controller,
            hint: AppLocal.tr(context, 'app.what_if'),
            minLine: 1,
          ),
        ),
        Expanded(
          child: AppIconButton(
            icon: const IconView(icon: AppIcons.arrowRight),
            onPressed: () async {
              final provider = ref.read(generateImageProvider.notifier);

              await provider.request(prompt: controller.text);
            },
          ),
        ),
      ],
    );
  }
}
