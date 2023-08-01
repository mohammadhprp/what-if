import 'package:flutter/material.dart';

import '../../../../constants/database/database_column_name.dart';
import '../../../../constants/database/database_table_name.dart';
import '../../../../services/supabase_service.dart';
import '../../../../utils/storage/user_info.dart';

class PostLikeNotifier extends ChangeNotifier {
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

  Future<void> unlike(int postId) async {
    final userId = await UserInfo.userId();
    // Delete post like data
    Map<String, dynamic> where = {
      DatabaseColumnName.userId: userId,
      DatabaseColumnName.postId: postId,
    };

    await supabase.delete(
      DatabaseTableName.postLikes,
      where,
    );
  }

  Future<bool> isPostLiked(int postId) async {
    final userId = await UserInfo.userId();

    // Columns
    String fields = """ 
      "${DatabaseColumnName.userId}",
      "${DatabaseColumnName.postId}"
    """;

    // Where
    Map query = {
      DatabaseColumnName.userId: userId,
      DatabaseColumnName.postId: postId,
    };

    // Check if find any like post with give user_id and post_id
    final data = await supabase.getWhere(
      DatabaseTableName.postLikes,
      fields,
      query,
    );

    return data != null;
  }
}
