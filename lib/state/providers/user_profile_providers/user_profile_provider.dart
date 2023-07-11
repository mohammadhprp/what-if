import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/user_profile/user_profile_model.dart';
import '../../notifiers/user_profile_notifiers/user_profile_notifier.dart';

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfileModel?>(
  (_) => UserProfileNotifier(),
);

final fetchCurrentUserProfileProvider = FutureProvider((ref) async {
  final provider = ref.watch(userProfileProvider.notifier);
  return await provider.fetch();
});
