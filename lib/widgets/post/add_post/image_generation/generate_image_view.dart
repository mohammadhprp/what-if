import 'package:flutter/material.dart';

import '../../../../../constants/values_manager/values_manager.dart';
import 'generate_image_form.dart';
import 'image_generation.dart';

class GenerateImageView extends StatelessWidget {
  const GenerateImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        GenerateImageForm(),
        SizedBox(height: AppSize.s20),
        ImageGeneration(),
      ],
    );
  }
}
