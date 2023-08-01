import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../notifiers/post_notifiers/post_like_notifiers/post_like_notifier.dart';

final postLikeProvider = ChangeNotifierProvider<PostLikeNotifier>(
  (_) => PostLikeNotifier(),
);
