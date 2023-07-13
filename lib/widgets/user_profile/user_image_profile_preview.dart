import 'dart:io';

import 'package:flutter/material.dart';

import '../../components/icon/icon_view.dart';
import '../../components/images/image_file_view.dart';
import '../../constants/app/app_colors.dart';
import '../../constants/app/app_icons.dart';
import '../../constants/database/local_directory_name.dart';
import '../../constants/values_manager/values_manager.dart';

class UserImageProfilePreview extends StatelessWidget {
  final String? image;
  final File? pickedImage;

  const UserImageProfilePreview({
    super.key,
    required this.image,
    required this.pickedImage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        pickedImage != null
            ? ImageFileViewer(
                image: pickedImage!,
                border: Border.all(
                  color: AppColors.primary,
                  width: AppSize.s2,
                ),
              )
            : ImageFileView(
                image: image,
                dir: LocalDirectoryName.userProfile,
                border: Border.all(
                  color: AppColors.primary,
                  width: AppSize.s2,
                ),
              ),
        Positioned.fill(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary36,
            ),
            child: const IconView(
              icon: AppIcons.edit,
              height: AppSize.s50,
              color: AppColors.primary,
            ),
          ),
        )
      ],
    );
  }
}
