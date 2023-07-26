import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../notifiers/story_notifiers/story_list_notifier.dart';

final storyListProvider = ChangeNotifierProvider<StoryListNotifier>(
  (_) => StoryListNotifier(),
);

final fetchStoriesProvider = FutureProvider<void>((ref) async {
  final provider = ref.read(storyListProvider);

  if (provider.list.isEmpty && !provider.isLoading) {
    await provider.fetch();
  }
});
