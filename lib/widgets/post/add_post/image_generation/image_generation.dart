import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../constants/enums/generate_status.dart';
import '../../../../../state/providers/post_providers/generate_image_provider.dart';
import 'image_generation_state/generating_image_in_progress.dart';
import 'image_generation_state/image_generation_failed.dart';
import 'image_generation_state/image_generation_successful.dart';
import 'image_generation_state/waiting_to_generate_image.dart';

class ImageGeneration extends ConsumerWidget {
  const ImageGeneration({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(generateImageProvider);

    return switch (state) {
      GenerateStatus.notStarted => const WaitingToGenerateImage(),
      GenerateStatus.loading => const GeneratingImageInProgress(),
      GenerateStatus.success => const ImageGenerationSuccessful(),
      GenerateStatus.error => const ImageGenerationFailed(),
    };
  }
}
