import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../../components/buttons/elevated_button.dart';
import '../../../../../../components/images/image_file_view.dart';
import '../../../../../../constants/app/app_colors.dart';
import '../../../../../../constants/enums/create_post_state.dart';
import '../../../../../../constants/extensions/media_query/media_query_extension.dart';
import '../../../../../../helpers/localization/app_local.dart';
import '../../../../../../state/providers/post_providers/create_post_provider.dart';
import '../../../../../../state/providers/post_providers/create_post_state_provider.dart';
import '../../../../../../state/providers/post_providers/generate_image_provider.dart';
import 'image_generator_place_holder.dart';

class ImageGenerationSuccessful extends ConsumerWidget {
  const ImageGenerationSuccessful({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(generateImageProvider.notifier);
    return ImageGeneratorPlaceHolder(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ImageFileViewer(
              height: context.height,
              width: context.width,
              image: provider.generatedImage,
              shape: BoxShape.rectangle,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              child: AppElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.black.withOpacity(0.8),
                ),
                onPressed: () {
                  // Update createPost state to next step
                  final state = ref.read(createPostStateProvider.notifier);
                  state.update(CreatePostState.edit);

                  // Add generated image
                  final postProvider = ref.read(createPostProvider.notifier);
                  final post = ref.read(createPostProvider);
                  postProvider.update(
                    post?.copyWithImage(provider.generatedImage),
                  );
                },
                child: Text(
                  AppLocal.tr(context, 'button.submit'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
