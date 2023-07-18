import 'package:flutter/material.dart';

import '../../../../../../components/loading/loading_view.dart';
import 'image_generator_place_holder.dart';

class GeneratingImageInProgress extends StatelessWidget {
  const GeneratingImageInProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const ImageGeneratorPlaceHolder(
      child: LoadingView(),
    );
  }
}
