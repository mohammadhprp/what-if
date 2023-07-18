import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/post/create_post_model.dart';
import '../../notifiers/post_notifiers/create_post_notifier.dart';

final createPostProvider =
    StateNotifierProvider<CreatePostNotifier, CreatePostModel?>(
  (_) => CreatePostNotifier(),
);
