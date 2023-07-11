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

      return state = UserProfileModel.fromJson(response);
    } catch (e) {
      throw MessageException('error.filed_to_get_user_profile');
    }
  }
}
