import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../components/dividers/horizontal_divider.dart';
import '../../../../constants/extensions/media_query/media_query_extension.dart';
import '../../../../constants/extensions/widget/padding_extension.dart';
import '../../../../constants/values_manager/values_manager.dart';
import '../../../../models/post/post_model.dart';
import '../../../../models/user_profile/user_profile_model.dart';
import 'post_item.dart';

class Posts extends HookConsumerWidget {
  const Posts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: context.height * 0.6,
      child: ListView.separated(
        itemCount: 10,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) {
          return const HorizontalDivider().padding([Edge.all], AppPadding.p10);
        },
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              PostItem(
                post: PostModel(
                  id: index,
                  user: UserProfileModel(
                    id: index,
                    uid: 'uid-$index',
                    name: 'name$index',
                    image: 'image-$index.jpg',
                    createdAt: DateTime.now().add(
                      Duration(seconds: index),
                    ),
                  ),
                  caption: 'caption-$index',
                  prompt: 'prompt-$index',
                  image: 'image-$index.jpg',
                  likeCount: index,
                  commentCount: index + 2,
                  createdAt: DateTime.now().add(
                    Duration(seconds: index),
                  ),
                ),
              ),
              if (index == 9)
                SizedBox(
                  height: context.height * 0.1,
                )
            ],
          );
        },
      ),
    ).padding([Edge.horizontal], AppPadding.p10);
  }
}
