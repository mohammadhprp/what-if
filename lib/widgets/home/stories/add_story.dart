import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../components/error/error_screen.dart';
import '../../../components/icon/icon_view.dart';
import '../../../components/images/image_file_view.dart';
import '../../../components/loading/loading_screen.dart';
import '../../../components/loading/loading_view.dart';
import '../../../constants/app/app_colors.dart';
import '../../../constants/app/app_icons.dart';
import '../../../constants/database/local_directory_name.dart';
import '../../../constants/extensions/logger/logger_extension.dart';
import '../../../constants/extensions/media_query/media_query_extension.dart';
import '../../../constants/extensions/theme/theme_extension.dart';
import '../../../constants/values_manager/values_manager.dart';
import '../../../helpers/image/image_picker_content.dart';
import '../../../helpers/localization/app_local.dart';
import '../../../state/providers/story_providers/add_story_provider.dart';
import '../../../state/providers/user_profile_providers/user_profile_provider.dart';

class AddStory extends ConsumerWidget {
  const AddStory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentProfile = ref.watch(fetchCurrentUserProfileProvider);
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return ImagePickerContent(
              hasImage: false,
              onPicked: (File? pickedImage) async {
                if (pickedImage == null) {
                  return;
                }

                try {
                  LoadingScreen.instance().show(
                    context: context,
                    text: AppLocal.tr(context, 'app.loading'),
                  );
                  // Upload Image
                  await ref.read(addStoryProvider).store(pickedImage);
                } catch (e) {
                  e.eLog();
                  ErrorScreen.instance().show(
                    context: context,
                    text: AppLocal.tr(context, 'error.upload_failed'),
                  );
                } finally {
                  LoadingScreen.instance().hide();
                }
              },
            );
          },
        );
      },
      child: currentProfile.when(
        data: (_) {
          final profile = ref.watch(userProfileProvider);
          return Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ImageFileView(
                    image: profile?.image,
                    dir: LocalDirectoryName.userProfile,
                    height: context.height * 0.09,
                    width: context.height * 0.09,
                    fit: BoxFit.cover,
                    border: Border.all(
                      color: AppColors.primary,
                      width: AppSize.s5,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: context.colors.primary.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: IconView(
                        icon: AppIcons.add,
                        color: context.colors.onBackground,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: AppSize.s12),
              Text(profile?.name ?? ''),
            ],
          );
        },
        error: (error, __) {
          return const Text('error');
        },
        loading: () => const LoadingView(),
      ),
    );
  }
}
