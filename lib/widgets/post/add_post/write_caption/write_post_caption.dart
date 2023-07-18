import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../components/text_field/text_box_field.dart';
import '../../../../constants/enums/create_post_state.dart';
import '../../../../helpers/localization/app_local.dart';
import '../../../../state/providers/post_providers/create_post_provider.dart';
import '../../../../state/providers/post_providers/create_post_state_provider.dart';

class WritePostCaption extends HookConsumerWidget {
  const WritePostCaption({super.key});

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

    return Column(
      children: [
        TextBoxField(
          controller: controller,
          hint: AppLocal.tr(context, 'form.message'),
          minLine: 4,
          onFiledSubmitted: textFieldHaveIsNotEmpty.value
              ? (value) {
                  // Update createPost state to next step
                  final state = ref.read(createPostStateProvider.notifier);
                  state.update(CreatePostState.review);

                  // Add post caption
                  final postProvider = ref.read(createPostProvider.notifier);
                  final post = ref.read(createPostProvider);
                  postProvider.update(
                    post?.copyWithCaption(value),
                  );
                }
              : null,
        ),
      ],
    );
  }
}
