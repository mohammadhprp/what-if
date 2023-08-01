import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'post_like_provider.dart';

final isPostLiedProvider = FutureProvider.family<bool, int>((
  ref,
  postId,
) async {
  final provider = ref.read(postLikeProvider);
  return await provider.isPostLiked(postId);
});
