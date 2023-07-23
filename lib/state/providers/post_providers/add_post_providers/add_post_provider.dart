import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../notifiers/post_notifiers/add_post_notifiers/add_post_notifier.dart';

final addPostProvider = ChangeNotifierProvider<AddPostNotifier>(
  (ref) => AddPostNotifier(),
);
