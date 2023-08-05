import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/follow/follow_count.dart';
import '../../notifiers/follow_notifiers/follow_notifier.dart';

final followProvider = StateNotifierProvider<FollowNotifier, FollowCount>(
  (_) => FollowNotifier(),
);

final myFollowProvider = FutureProvider<FollowCount>((ref) async {
  final provider = ref.read(followProvider.notifier);
  return await provider.me();
});

final userFollowProvider = FutureProvider.family<void, String>((
  ref,
  userId,
) async {
  final provider = ref.read(followProvider.notifier);
  return await provider.user(userId);
});

final isUserFollowedProvider = FutureProvider.family<bool, String>((
  ref,
  userId,
) async {
  final provider = ref.read(followProvider.notifier);
  return await provider.isFollowed(userId);
});
