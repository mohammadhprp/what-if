import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/buttons/outlined_button.dart';
import '../../components/images/image_file_view.dart';
import '../../components/loading/loading_view.dart';
import '../../constants/app/app_colors.dart';
import '../../constants/database/local_directory_name.dart';
import '../../constants/extensions/media_query/media_query_extension.dart';
import '../../constants/values_manager/values_manager.dart';
import '../../helpers/localization/app_local.dart';
import '../../screens/user_profile/user_edit_profile_screen.dart';
import '../../state/providers/user_profile_providers/user_profile_provider.dart';

class UserProfileInfo extends HookConsumerWidget {
  const UserProfileInfo({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentProfile = ref.watch(fetchCurrentUserProfileProvider);
    return Column(
      children: [
        currentProfile.when(
          data: (_) {
            final profile = ref.watch(userProfileProvider);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profile!.name),
                    const Text('admin@gmail.com'),
                  ],
                ),
                ImageFileView(
                  image: profile.image,
                  dir: LocalDirectoryName.userProfile,
                  height: context.height * 0.12,
                  fit: BoxFit.cover,
                  border: Border.all(
                    color: AppColors.primary,
                    width: AppSize.s2,
                  ),
                ),
              ],
            );
          },
          error: (error, __) {
            return const Text('error');
          },
          loading: () => const LoadingView(),
        ),
        const SizedBox(height: AppSize.s20),
        Row(
          children: [
            Expanded(
              child: AppOutlinedButton(
                height: AppSize.s50,
                onPressed: () async {
                  final provider = ref.read(userProfileProvider.notifier);
                  await provider.fetch().then(
                    (profile) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UserEditProfileScreen(
                            profile: profile,
                          ),
                        ),
                      );
                    },
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: Text(
                  AppLocal.tr(context, 'app.edit_profile'),
                ),
              ),
            ),
            const SizedBox(width: AppSize.s20),
            Expanded(
              child: AppOutlinedButton(
                height: AppSize.s50,
                onPressed: () {
                  // TODO: share user profile
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: Text(
                  AppLocal.tr(context, 'app.share_profile'),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSize.s20),
      ],
    );
  }
}
