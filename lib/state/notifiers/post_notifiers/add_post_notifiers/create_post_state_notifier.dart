import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/enums/create_post_state.dart';

class CreatePostStateNotifier extends StateNotifier<CreatePostState> {
  CreatePostStateNotifier() : super(CreatePostState.generate);

  void update(CreatePostState value) => state = value;
}
