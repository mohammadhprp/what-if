import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/enums/create_post_state.dart';
import '../../notifiers/post_notifiers/add_post_notifiers/create_post_state_notifier.dart';

final createPostStateProvider =
    StateNotifierProvider<CreatePostStateNotifier, CreatePostState>(
  (ref) => CreatePostStateNotifier(),
);
