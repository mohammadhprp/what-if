import 'package:flutter/material.dart';

import '../../constants/app/app_colors.dart';
import '../../constants/app/app_icons.dart';
import '../../constants/extensions/media_query/media_query_extension.dart';
import '../../constants/values_manager/values_manager.dart';
import '../buttons/elevated_button.dart';
import '../dividers/horizontal_divider.dart';
import '../icon/icon_view.dart';
import 'alert_dialog_button.dart';

@immutable
class AlertDialogModel<T> {
  final String title;
  final String message;
  final AlertDialogButton<T> buttons;
  final Alignment alignment;

  const AlertDialogModel({
    required this.title,
    required this.message,
    required this.buttons,
    this.alignment = Alignment.center,
  });
}

extension Present<T> on AlertDialogModel<T> {
  Future<T?> present(BuildContext context) {
    return showDialog<T?>(
      context: context,
      barrierColor: AppColors.black100.withOpacity(0.89),
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(AppSize.s12),
          content: Align(
            alignment: alignment,
            child: Container(
              width: context.width * 0.95,
              padding: const EdgeInsets.all(AppSize.s16),
              decoration: BoxDecoration(
                color: AppColors.white100,
                borderRadius: BorderRadius.circular(AppSize.s12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(false),
                        child: const IconView(icon: AppIcons.closeCircle),
                      )
                    ],
                  ),
                  const SizedBox(height: AppSize.s10),
                  const HorizontalDivider(),
                  const SizedBox(height: AppSize.s10),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSize.s40),
                  Wrap(
                    spacing: AppSize.s8,
                    children: buttons.content.entries.map(
                      (entry) {
                        if (entry.value == false) {
                          return SizedBox(
                            width: context.width * 0.35,
                            child: AppElevatedButton(
                              onPressed: () => Navigator.of(context).pop(
                                entry.value,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryLight,
                              ),
                              child: Text(entry.key),
                            ),
                          );
                        }
                        return SizedBox(
                          width: context.width * 0.35,
                          child: AppElevatedButton(
                            onPressed: () => Navigator.of(context).pop(
                              entry.value,
                            ),
                            child: Text(entry.key),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
