import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../components/icon/icon_view.dart';
import '../../../constants/app/app_icons.dart';
import '../../../constants/extensions/theme/theme_extension.dart';
import '../../../state/notifiers/post_notifiers/post_like_notifiers/post_like_notifier.dart';
import '../../../state/notifiers/post_notifiers/post_list_notifiers/post_list_notifier.dart';
import '../../../state/providers/post_providers/post_like_providers/post_like_provider.dart';
import '../../../state/providers/post_providers/post_list_providers/post_list_provider.dart';

class PostLikeButton extends ConsumerWidget {
  final int postId;
  final int likeCount;
  final bool isPostAlreadyLiked;
  const PostLikeButton({
    super.key,
    required this.postId,
    required this.likeCount,
    required this.isPostAlreadyLiked,
  });

  void like(PostLikeNotifier likeProvider, PostListNotifier postProvider) {
    try {
      likeProvider.like(postId);

      // Update post like count in post list
      postProvider.update(
        postId,
        likeCount: likeCount + 1,
        isPostLiked: true,
      );
    } on Exception {
      /// Undo post like count and status
      postProvider.update(
        postId,
        likeCount: likeCount,
        isPostLiked: false,
      );
    }
  }

  void unlike(PostLikeNotifier likeProvider, PostListNotifier postProvider) {
    try {
      likeProvider.unlike(postId);

      // Update post like count in post list
      postProvider.update(
        postId,
        likeCount: likeCount - 1,
        isPostLiked: false,
      );
    } on Exception {
      /// Undo post like count and status
      postProvider.update(
        postId,
        likeCount: likeCount,
        isPostLiked: true,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
      ),
      onPressed: () {
        final likeProvider = ref.read(postLikeProvider);
        final postProvider = ref.read(postListProvider);

        /// Check is post liked
        if (isPostAlreadyLiked) {
          // Unlike post on tap
          unlike(likeProvider, postProvider);
        } else {
          // Like post on tap
          like(likeProvider, postProvider);
        }
      },
      icon: IconView(
        icon: isPostAlreadyLiked ? AppIcons.heartBold : AppIcons.heart,
        color: context.colors.onBackground,
      ),
      label: Text("$likeCount"),
    );
  }
}
