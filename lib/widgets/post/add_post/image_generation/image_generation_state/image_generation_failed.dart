import 'package:flutter/material.dart';

import '../../../../../../helpers/localization/app_local.dart';
import 'image_generator_place_holder.dart';

class ImageGenerationFailed extends StatelessWidget {
  const ImageGenerationFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageGeneratorPlaceHolder(
      child: Text(
        AppLocal.tr(context, 'error.an_error_happened'),
      ),
    );
  }
}
