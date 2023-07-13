import 'dart:io';

import 'package:flutter/material.dart';

import '../../components/icon/icon_view.dart';
import '../../constants/app/app_icons.dart';
import '../../constants/extensions/media_query/media_query_extension.dart';
import '../../constants/values_manager/values_manager.dart';
import '../localization/app_local.dart';
import 'image_picker_helper.dart';

class ImagePickerContent extends StatelessWidget {
  final bool hasImage;
  final ValueChanged<File?> onPicked;
  final VoidCallback? onDelete;
  const ImagePickerContent({
    super.key,
    required this.hasImage,
    required this.onPicked,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(15),
      content: Container(
        width: context.width,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.all(Radius.circular(18)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: IconView(
                      icon: AppIcons.closeCircle,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocal.tr(context, 'select_image'),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      Opacity(
                        opacity: 0.5,
                        child: Text(
                          AppLocal.tr(
                            context,
                            'select_image_from_camera_or_gallery',
                          ),
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: CustomIconButton(
                        onTap: () async {
                          await ImagePickerHelper.pickImageFromCamera().then(
                            (value) {
                              if (value != null) {
                                onPicked.call(value);

                                Navigator.of(context).pop();
                              }
                            },
                          );
                        },
                        title: AppLocal.tr(context, 'camera'),
                        icon: AppIcons.camera,
                      ),
                    ),
                    const SizedBox(width: AppSize.s8),
                    Expanded(
                      child: CustomIconButton(
                        onTap: () async {
                          await ImagePickerHelper.pickImageFromGallery().then(
                            (value) {
                              if (value != null) {
                                onPicked.call(value);

                                Navigator.of(context).pop();
                              }
                            },
                          );
                        },
                        title: AppLocal.tr(context, 'gallery'),
                        icon: AppIcons.gallery,
                      ),
                    ),
                  ],
                ),
                if (hasImage)
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 12),
                          child: CustomIconButton(
                            onTap: onDelete,
                            title: AppLocal.tr(context, 'delete_image'),
                            icon: AppIcons.trash,
                            textColor: Theme.of(context).colorScheme.error,
                            iconColor: Theme.of(context).colorScheme.error,
                            color: Theme.of(context)
                                .colorScheme
                                .error
                                .withOpacity(0.08),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final String title;
  final String icon;
  final Function()? onTap;
  final Color? textColor;
  final Color? iconColor;
  final double? height;
  final double? width;
  final Color? color;
  const CustomIconButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.textColor,
    this.iconColor,
    this.height,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 70,
        width: width ?? 130,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconView(
              icon: icon,
              color: iconColor ?? Theme.of(context).colorScheme.outline,
              height: 24,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
