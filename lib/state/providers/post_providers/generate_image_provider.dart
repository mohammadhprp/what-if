import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/enums/generate_status.dart';
import '../../notifiers/post_notifiers/add_post_notifiers/generate_image_notifier.dart';

final generateImageProvider =
    StateNotifierProvider<GenerateImageNotifier, GenerateStatus>(
  (_) => GenerateImageNotifier(),
);
