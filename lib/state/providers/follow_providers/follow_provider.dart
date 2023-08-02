import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/follow/follow_count.dart';
import '../../notifiers/follow_notifiers/follow_notifier.dart';

final followProvider = StateNotifierProvider<FollowNotifier, FollowCount>(
  (_) => FollowNotifier(),
);

final myFollowProvider = FutureProvider((ref) async {
  final provider = ref.read(followProvider.notifier);
  await provider.me();
});
