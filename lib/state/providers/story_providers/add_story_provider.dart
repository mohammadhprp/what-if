import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../notifiers/story_notifiers/add_story_notifier.dart';

final addStoryProvider = ChangeNotifierProvider<AddStoryNotifier>(
  (_) => AddStoryNotifier(),
);
