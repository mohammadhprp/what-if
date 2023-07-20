import 'package:flutter/material.dart';

import '../../../../components/buttons/outlined_button.dart';
import '../../../../components/icon/icon_view.dart';
import '../../../../constants/app/app_icons.dart';
import '../../../../constants/extensions/media_query/media_query_extension.dart';
import '../../../../constants/extensions/theme/theme_extension.dart';
import '../../../../constants/values_manager/values_manager.dart';
import '../../../../helpers/localization/app_local.dart';

class UploadPost extends StatelessWidget {
  const UploadPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconView(
          icon: AppIcons.gallery,
          height: context.height * 0.1,
          color: context.colors.onBackground,
        ),
        const SizedBox(height: AppSize.s20),
        Text(
          AppLocal.tr(context, 'app.done'),
          style: context.textTheme.displayMedium,
        ),
        const SizedBox(height: AppSize.s20),
        AppOutlinedButton(
          onPressed: () {
            // TODO: go to post detail screen
          },
          child: Text(
            AppLocal.tr(context, 'app.view_post'),
          ),
        ),
      ],
    );
  }
}
