import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/user_profile/user_profile_model.dart';
import '../../notifiers/user_profile_notifiers/user_profile_notifier.dart';

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfileModel?>(
  (_) => UserProfileNotifier(),
);

/// Fetch current user profile
final fetchCurrentUserProfileProvider = FutureProvider((ref) async {
  final provider = ref.watch(userProfileProvider.notifier);
  return await provider.fetch();
});

/// Update current user profile
final updateProvider =
    Provider.family<Future<void>, ({UserProfileModel profile, File? image})>((
  ref,
  updatedProfile,
) async {
  final provider = ref.watch(userProfileProvider.notifier);
  await provider.update(
    profile: updatedProfile.profile,
    image: updatedProfile.image,
  );
});
