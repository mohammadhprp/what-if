import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../constants/database/database_column_name.dart';
import '../../../constants/database/database_table_name.dart';
import '../../../constants/database/local_storage_name.dart';
import '../../../helpers/storage/local_storage.dart' as lg;
import '../../../models/user_profile/user_profile_model.dart';
import '../../../utils/exceptions/message_exception.dart';

class UserProfileNotifier extends StateNotifier<UserProfileModel?> {
  UserProfileNotifier() : super(null);

  Future<UserProfileModel> fetch() async {
    try {
      // Check profile is stored in local storage
      final isProfileStored = await lg.LocalStorage.isExist(
        key: LocalStorageName.userProfile,
      );

      /// Fetch user profile from local storage
      if (isProfileStored) {
        final profile = await _fetchFromLocal();
        state = profile;
        return profile;
      }

      /// Fetch user profile from local backend
      final profile = await _fetchFromBackend();
      state = profile;
      return profile;
    } catch (e) {
      throw MessageException('error.filed_to_get_user_profile');
    }
  }

  /// Fetch user  profile info from backend
  /// Then store info in local storage
  Future<UserProfileModel> _fetchFromBackend() async {
    final supabase = Supabase.instance.client;

    const query = "${DatabaseColumnName.id}, "
        "${DatabaseColumnName.name}, "
        "${DatabaseColumnName.image}, "
        "${DatabaseColumnName.createdAt}";

    final userId = await lg.LocalStorage.get(key: LocalStorageName.userId);

    final Map<String, dynamic> response = await supabase
        .from(DatabaseTableName.userProfiles)
        .select(query)
        .eq(DatabaseColumnName.userId, userId)
        .single();

    final userProfile = UserProfileModel.fromJson(response);

    _storeUserProfile(profile: userProfile);

    return userProfile;
  }

  /// Fetch user  profile info from local storage
  Future<UserProfileModel> _fetchFromLocal() async {
    final userProfile = await lg.LocalStorage.get(
      key: LocalStorageName.userProfile,
    );

    if (userProfile == null) {
      throw Exception('User profile is null');
    }

    final profile = jsonDecode(userProfile);

    return UserProfileModel.fromJson(profile);
  }

  Future<void> _storeUserProfile({required UserProfileModel profile}) async {
    await lg.LocalStorage.store(
      key: LocalStorageName.userProfile,
      value: profile.toRawJson(),
    );
  }
}
