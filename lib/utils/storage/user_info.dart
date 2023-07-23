import 'dart:convert';

import '../../constants/database/local_storage_name.dart';
import '../../helpers/storage/local_storage.dart';
import '../../models/user_profile/user_profile_model.dart';

class UserInfo {
  static Future<UserProfileModel> profile() async {
    final userProfile = await LocalStorage.get(
      key: LocalStorageName.userProfile,
    );

    if (userProfile == null) {
      throw Exception('User profile is null');
    }

    final profile = jsonDecode(userProfile);

    return UserProfileModel.fromJson(profile);
  }
}
