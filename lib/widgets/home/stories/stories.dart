import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/extensions/media_query/media_query_extension.dart';
import '../../../constants/extensions/widget/padding_extension.dart';
import '../../../constants/values_manager/values_manager.dart';
import '../../../models/story/story_model.dart';
import '../../../models/user_profile/user_profile_model.dart';
import 'story_item.dart';

class Stories extends HookConsumerWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: context.height * 0.2,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: AppSize.s10);
        },
        itemBuilder: (BuildContext context, int index) {
          return StoryItem(
            story: StoryModel(
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
              image: 'image-$index.jpg',
              createdAt: DateTime.now().add(
                Duration(seconds: index),
              ),
            ),
          );
        },
      ),
    ).padding([Edge.leading], 10);
  }
}
