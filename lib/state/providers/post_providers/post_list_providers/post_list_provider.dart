import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../notifiers/post_notifiers/post_list_notifiers/post_list_notifier.dart';

final postListProvider = ChangeNotifierProvider<PostListNotifier>(
  (_) => PostListNotifier(),
);

final fetchPostsProvider = FutureProvider<void>((ref) async {
  final provider = ref.read(postListProvider);

  if (provider.list.isEmpty && !provider.isLoading) {
    await provider.fetch();
  }
});
