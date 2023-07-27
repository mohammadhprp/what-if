import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../components/loading/loading_view.dart';
import '../../../constants/extensions/media_query/media_query_extension.dart';
import '../../../constants/extensions/widget/padding_extension.dart';
import '../../../constants/values_manager/values_manager.dart';
import '../../../helpers/localization/app_local.dart';
import '../../../state/providers/story_providers/story_list_provider.dart';
import 'story_item.dart';

class Stories extends HookConsumerWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchStories = ref.watch(fetchStoriesProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p10,
      ),
      child: Row(
        children: [
          Expanded(
            child: fetchStories.when(
              data: (_) {
                final provider = ref.watch(storyListProvider);
                final stories = provider.list;
                final length = stories.length;

                if (stories.isEmpty) {
                  return Center(
                    child: Text(AppLocal.tr(context, 'app.empty_list')),
                  );
                }
                return SizedBox(
                  height: context.height * 0.2,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: AppSize.s10);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final story = stories[index];
                      return StoryItem(
                        story: story,
                      );
                    },
                  ),
                ).padding([Edge.leading], AppPadding.p10);
              },
              error: (e, _) => const Text('error'),
              loading: () => const LoadingView(),
            ),
          ),
        ],
      ),
    );
  }
}
