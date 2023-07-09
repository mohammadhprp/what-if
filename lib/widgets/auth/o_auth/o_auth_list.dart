import 'package:flutter/material.dart';

import '../../../components/buttons/icon_button.dart';
import '../../../components/icon/icon_view.dart';
import '../../../constants/app/app_icons.dart';

class OAuthList extends StatelessWidget {
  const OAuthList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AppIconButton(icon: IconView(icon: AppIcons.google)),
        AppIconButton(icon: IconView(icon: AppIcons.facebook)),
        AppIconButton(icon: IconView(icon: AppIcons.github)),
      ],
    );
  }
}
