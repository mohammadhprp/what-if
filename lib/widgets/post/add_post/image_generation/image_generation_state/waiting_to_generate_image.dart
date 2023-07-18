import 'package:flutter/material.dart';

import '../../../../../../helpers/localization/app_local.dart';
import 'image_generator_place_holder.dart';

class WaitingToGenerateImage extends StatelessWidget {
  const WaitingToGenerateImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageGeneratorPlaceHolder(
      child: Text(
        AppLocal.tr(context, 'app.enter_your_prompt'),
      ),
    );
  }
}
