import 'package:flutter/material.dart';

import '../../../../constants/database/database_column_name.dart';
import '../../../../constants/database/database_table_name.dart';
import '../../../../services/supabase_service.dart';
import '../../../../utils/storage/user_info.dart';

class LikePostNotifier extends ChangeNotifier {
  final supabase = SupabaseService();

  Future<void> like(int postId) async {
    final userId = await UserInfo.userId();
    // Insert post like data
    Map<String, dynamic> fields = {
      DatabaseColumnName.userId: userId,
      DatabaseColumnName.postId: postId,
    };

    await supabase.insert(
      DatabaseTableName.postLikes,
      fields,
    );
  }
}
