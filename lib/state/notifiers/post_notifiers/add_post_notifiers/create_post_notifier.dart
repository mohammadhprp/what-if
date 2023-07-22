import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../models/post/create_post_model.dart';

class CreatePostNotifier extends StateNotifier<CreatePostModel?> {
  CreatePostNotifier() : super(null);

  void update(CreatePostModel? post) {
    state = post;
  }
}
