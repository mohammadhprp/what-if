import 'dart:convert';
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../constants/database/database_column_name.dart';
import '../../../constants/database/database_table_name.dart';
import '../../../constants/database/local_directory_name.dart';
import '../../../constants/database/local_storage_name.dart';
import '../../../constants/database/storage_bucket_name.dart';
import '../../../constants/extensions/file/get_file.dart';
import '../../../constants/extensions/logger/logger_extension.dart';
import '../../../helpers/storage/local_directory.dart';
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
      throw MessageException('error.failed_to_get_user_profile');
    }
  }

  Future<void> update({
    required UserProfileModel profile,
    File? image,
  }) async {
    try {
      final supabase = Supabase.instance.client;

      final userId = await lg.LocalStorage.get(key: LocalStorageName.userId);

      Map<String, String> fields = {
        DatabaseColumnName.name: profile.name,
      };

      // Upload image
      if (image != null && profile.image != state?.image) {
        final path = await supabase.storage
            .from(StorageBucketName.userProfileImages)
            .upload('$userId/${image.getFileName}', image);

        final newImagePath = path.split('/').last;

        final imageFiled = {DatabaseColumnName.image: newImagePath};

        fields.addEntries(imageFiled.entries);

        profile = profile.copyWith(image: newImagePath);

        //Store image in Device
        await LocalDirectory.store(
          dir: LocalDirectoryName.userProfile,
          file: image,
        );

        // Delete old image
        if (await LocalDirectory.isExist(
          dir: LocalDirectoryName.userProfile,
          name: state?.image,
        )) {
          await LocalDirectory.delete(
            dir: LocalDirectoryName.userProfile,
            name: state?.image,
          );
        }
      }

      // Update backend database
      await supabase
          .from(DatabaseTableName.userProfiles)
          .update(fields)
          .match({DatabaseColumnName.userId: userId});

      // Update local storage
      _storeUserProfile(profile: profile);

      state = profile;
    } catch (e) {
      e.eLog();
      throw MessageException('error.failed_to_update_user_profile');
    }
  }

  /// Fetch user  profile info from backend
  /// Then store info in local storage
  Future<UserProfileModel> _fetchFromBackend() async {
    final supabase = Supabase.instance.client;

    const query = "${DatabaseColumnName.id}, "
        "${DatabaseColumnName.userId}, "
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

    /// Check profile image not null
    /// And don't exist in local storage
    if (userProfile.image != null &&
        !await LocalDirectory.isExist(
            dir: LocalDirectoryName.userProfile, name: userProfile.image!)) {
      // Download and Save profile image in Device
      final image = await supabase.storage
          .from(StorageBucketName.userProfileImages)
          .download('$userId/${userProfile.image}');

      await LocalDirectory.storeFromBytes(
        name: userProfile.image!,
        dir: LocalDirectoryName.userProfile,
        file: image,
      );
    }

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
