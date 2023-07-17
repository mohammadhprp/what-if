import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/enums/generate_status.dart';
import '../../backend/post/generate_image.dart';

class GenerateImageNotifier extends StateNotifier<GenerateStatus> {
  GenerateImageNotifier() : super(GenerateStatus.notStarted);

  late File generatedImage;

  final _generate = GenerateImage();

  Future<void> request({required String prompt}) async {
    try {
      state = GenerateStatus.loading;

      // Send a request to generate image
      generatedImage = await _generate.request(prompt: prompt);

      state = GenerateStatus.success;
    } catch (e) {
      state = GenerateStatus.error;
    }
  }
}
