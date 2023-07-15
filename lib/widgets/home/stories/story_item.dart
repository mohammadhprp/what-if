import 'package:flutter/material.dart';

import '../../../constants/extensions/theme/theme_extension.dart';
import '../../../constants/values_manager/values_manager.dart';
import '../../../models/story/story_model.dart';

class StoryItem extends StatelessWidget {
  final StoryModel story;
  const StoryItem({
    super.key,
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: AppSize.s40,
          backgroundColor: context.theme.colorScheme.primary,
          child: CircleAvatar(
            radius: AppSize.s35,
            backgroundColor: context.theme.colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: AppSize.s12),
        Text(story.user.name)
      ],
    );
  }
}
