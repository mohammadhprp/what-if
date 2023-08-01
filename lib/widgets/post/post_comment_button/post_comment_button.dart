import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../components/icon/icon_view.dart';
import '../../../constants/app/app_icons.dart';
import '../../../constants/extensions/theme/theme_extension.dart';

class PostCommentButton extends ConsumerWidget {
  final int commentCount;
  const PostCommentButton({
    super.key,
    required this.commentCount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
      ),
      onPressed: () {
        // TODO: Got to comment page
      },
      icon: IconView(
        icon: AppIcons.comment,
        color: context.colors.onBackground,
      ),
      label: Text("$commentCount"),
    );
  }
}
