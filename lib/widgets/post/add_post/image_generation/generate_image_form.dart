import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../components/text_field/prompt_box_field.dart';
import '../../../../../helpers/localization/app_local.dart';
import '../../../../../models/post/create_post_model.dart';
import '../../../../../state/providers/post_providers/create_post_provider.dart';
import '../../../../../state/providers/post_providers/generate_image_provider.dart';

class GenerateImageForm extends HookConsumerWidget {
  const GenerateImageForm({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();

    final textFieldHaveIsNotEmpty = useState(false);

    useEffect(() {
      void listener() {
        textFieldHaveIsNotEmpty.value = controller.text.isNotEmpty;
      }

      controller.addListener(listener);

      return () {
        controller.removeListener(listener);
      };
    }, [controller]);

    return PromptBoxField(
      controller: controller,
      hint: AppLocal.tr(context, 'app.what_if'),
      minLine: 2,
      onFiledSubmitted: textFieldHaveIsNotEmpty.value
          ? (value) async {
              // Send a request to generate image from prompt
              final provider = ref.read(generateImageProvider.notifier);
              await provider.request(prompt: value);

              // Add user prompt
              final postProvider = ref.read(createPostProvider.notifier);
              postProvider.update(
                CreatePostModel(prompt: value),
              );
            }
          : null,
    );
  }
}
