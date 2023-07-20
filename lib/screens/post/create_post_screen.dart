import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/enums/create_post_state.dart';
import '../../constants/extensions/theme/theme_extension.dart';
import '../../constants/extensions/widget/padding_extension.dart';
import '../../constants/values_manager/values_manager.dart';
import '../../helpers/localization/app_local.dart';
import '../../state/providers/post_providers/create_post_state_provider.dart';
import '../../widgets/post/add_post/image_generation/generate_image_view.dart';
import '../../widgets/post/add_post/review_post/review_post.dart';
import '../../widgets/post/add_post/upload_post/upload_post.dart';
import '../../widgets/post/add_post/write_caption/write_post_caption.dart';

class CreatePostScreen extends ConsumerWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(createPostStateProvider);

    int currentStep = CreatePostState.values.indexWhere(
      (element) => state == element,
    );

    bool isGeneratingState = state == CreatePostState.generate;
    bool isEditingState = state == CreatePostState.edit;
    bool isReviewingState = state == CreatePostState.review;
    bool isUploadState = state == CreatePostState.upload;

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
      body: Stepper(
        controlsBuilder: (context, details) => Container(),
        currentStep: currentStep,
        steps: [
          Step(
            state: isGeneratingState
                ? StepState.editing
                : currentStep != 0
                    ? StepState.complete
                    : StepState.disabled,
            isActive: isGeneratingState,
            title: Text(AppLocal.tr(context, 'app.generate_image')),
            content: const GenerateImageView(),
          ),
          Step(
            state: isEditingState
                ? StepState.editing
                : currentStep != 1 && currentStep != 2 && currentStep != 3
                    ? StepState.disabled
                    : StepState.complete,
            isActive: isEditingState,
            title: Text(AppLocal.tr(context, 'app.write_caption')),
            content: const WritePostCaption(),
          ),
          Step(
            state: isReviewingState
                ? StepState.editing
                : currentStep != 2 && currentStep != 3
                    ? StepState.disabled
                    : StepState.complete,
            isActive: isReviewingState,
            title: Text(AppLocal.tr(context, 'app.review_your_post')),
            content: isReviewingState ? const ReviewPost() : Container(),
          ),
          Step(
            state: isUploadState
                ? StepState.editing
                : currentStep != 3
                    ? StepState.disabled
                    : StepState.complete,
            isActive: isUploadState,
            title: Text(AppLocal.tr(context, 'app.done')),
            content: isUploadState ? const UploadPost() : Container(),
          ),
        ],
      ).padding([Edge.all], AppPadding.p12),
    );
  }
}
