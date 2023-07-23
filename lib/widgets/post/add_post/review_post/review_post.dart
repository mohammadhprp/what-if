import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../components/buttons/elevated_button.dart';
import '../../../../components/images/image_file_view.dart';
import '../../../../components/loading/loading_screen.dart';
import '../../../../constants/enums/create_post_state.dart';
import '../../../../constants/extensions/media_query/media_query_extension.dart';
import '../../../../constants/extensions/theme/theme_extension.dart';
import '../../../../constants/values_manager/values_manager.dart';
import '../../../../helpers/localization/app_local.dart';
import '../../../../state/providers/post_providers/add_post_providers/add_post_provider.dart';
import '../../../../state/providers/post_providers/add_post_providers/create_post_provider.dart';
import '../../../../state/providers/post_providers/add_post_providers/create_post_state_provider.dart';
import '../../../../state/providers/post_providers/post_list_providers/post_list_provider.dart';

class ReviewPost extends ConsumerWidget {
  const ReviewPost({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(createPostProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: ImageFileViewer(
            // height: context.height,
            width: context.width,
            image: provider!.image!,
            shape: BoxShape.rectangle,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: AppSize.s24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocal.tr(context, 'app.prompt'),
              style: context.textTheme.titleMedium,
            ),
            Text(
              provider.prompt ?? '',
              style: context.textTheme.displayMedium,
            ),
          ],
        ),
        const SizedBox(height: AppSize.s16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocal.tr(context, 'app.caption'),
              style: context.textTheme.titleMedium,
            ),
            Text(
              provider.caption ?? '',
              style: context.textTheme.displayMedium,
            ),
          ],
        ),
        const SizedBox(height: AppSize.s24),
        AppElevatedButton(
          onPressed: () async {
            // Show loading popup
            LoadingScreen.instance().show(
              context: context,
              text: AppLocal.tr(context, 'app.loading'),
            );

            // Store the post
            final post = await ref.read(addPostProvider).store(provider);

            // Add stored post in the post list
            await ref.read(postListProvider).add(post);

            // Hide loading popup
            LoadingScreen.instance().hide();

            // Update createPost state to next step
            final state = ref.read(createPostStateProvider.notifier);
            state.update(CreatePostState.upload);
          },
          child: Text(AppLocal.tr(context, 'button.post')),
        )
      ],
    );
  }
}
