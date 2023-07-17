import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/buttons/elevated_button.dart';
import '../../components/error/error_screen.dart';
import '../../components/loading/loading_screen.dart';
import '../../components/text_field/context_text_field.dart';
import '../../constants/extensions/file/get_file.dart';
import '../../constants/extensions/widget/padding_extension.dart';
import '../../constants/values_manager/values_manager.dart';
import '../../helpers/image/image_picker_content.dart';
import '../../helpers/localization/app_local.dart';
import '../../models/user_profile/user_profile_model.dart';
import '../../services/analytics_service.dart';
import '../../state/providers/user_profile_providers/user_profile_provider.dart';
import '../../widgets/user_profile/user_image_profile_preview.dart';

class UserEditProfileScreen extends HookConsumerWidget {
  final UserProfileModel profile;

  Future<void> _update({
    required BuildContext context,
    required WidgetRef ref,
    required String name,
    required File? image,
  }) async {
    // Show loading popup
    LoadingScreen.instance().show(
      context: context,
      text: AppLocal.tr(context, 'app.loading'),
    );

    // New profile
    final updatedProfile = profile.copyWith(
      name: name,
      image: image?.getFileName,
    );

    // Update user profile
    await ref
        .read(updateProvider((image: image, profile: updatedProfile)))
        .whenComplete(() => LoadingScreen.instance().hide())
        .then((value) => Navigator.of(context).pop())
        .onError(
      (error, stackTrace) {
        // Track error
        AnalyticsService.track(
          key: 'user',
          value: {'profile.update': '${profile.id} => $error'},
        );

        // Show an error popup
        ErrorScreen.instance().show(
          context: context,
          text: AppLocal.tr(context, "$error"),
        );
      },
    );
  }

  const UserEditProfileScreen({
    super.key,
    required this.profile,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController(text: profile.name);

    final isButtonEnabled = useState(false);

    final imageName = useState(profile.image);
    final pickedImage = useState<File?>(null);

    useEffect(() {
      void listener() {
        // Check name and email to be valid
        final name = nameController.text.trim();
        // final image = pickedImage
        isButtonEnabled.value = name.isNotEmpty && name != profile.name;
      }

      nameController.addListener(listener);

      return () {
        nameController.removeListener(listener);
      };
    }, [nameController]);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocal.tr(context, 'app.update_user_profile'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ImagePickerContent(
                        hasImage: imageName.value != null &&
                            imageName.value!.isNotEmpty,
                        onPicked: (File? value) {
                          if (value != null) {
                            pickedImage.value = value;
                            imageName.value = value.path.split('/').last;
                            isButtonEnabled.value = true;
                          }
                        },
                        onDelete: () {
                          // TODO: Delete image
                        },
                      );
                    },
                  );
                },
                child: UserImageProfilePreview(
                  image: imageName.value,
                  pickedImage: pickedImage.value,
                ),
              ),
              const SizedBox(height: AppSize.s28),
              ContextTextField(
                hint: AppLocal.tr(context, 'form.enter_your_name'),
                controller: nameController,
              ),
            ],
          ),
          AppElevatedButton(
            onPressed: isButtonEnabled.value
                ? () => _update(
                      context: context,
                      ref: ref,
                      name: nameController.text,
                      image: pickedImage.value,
                    )
                : null,
            child: Text(
              AppLocal.tr(context, 'button.update'),
            ),
          ),
        ],
      ).padding([Edge.all], AppSize.s16),
    );
  }
}
