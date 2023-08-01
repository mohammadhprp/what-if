import 'package:flutter/material.dart';

import '../../../../constants/database/database_column_name.dart';
import '../../../../constants/database/database_table_name.dart';
import '../../../../constants/database/storage_bucket_name.dart';
import '../../../../constants/extensions/logger/logger_extension.dart';
import '../../../../constants/typedefs.dart';
import '../../../../models/post/post_model.dart';
import '../../../../services/supabase_service.dart';
import '../../../../utils/exceptions/message_exception.dart';
import '../../../../utils/storage/user_info.dart';

class PostListNotifier extends ChangeNotifier {
  final supabase = SupabaseService();
  IsLoading _isLoading = false;
  IsLoading get isLoading => _isLoading;
  List<PostModel> _list = [];
  List<PostModel> get list => _list;

  Future<void> fetch() async {
    try {
      final userId = await UserInfo.userId();

      _isLoading = true;

      String fields = """
        ${DatabaseColumnName.id}, 
        ${DatabaseTableName.userProfiles} (
          ${DatabaseColumnName.id},
          ${DatabaseColumnName.userId},
          ${DatabaseColumnName.name},
          ${DatabaseColumnName.image},
          ${DatabaseColumnName.createdAt}
        ), 
        ${DatabaseColumnName.prompt}, 
        ${DatabaseColumnName.caption}, 
        ${DatabaseColumnName.image}, 
        ${DatabaseColumnName.likeCount}, 
        ${DatabaseColumnName.commentCount}, 
        ${DatabaseColumnName.createdAt}
      """;

      final List response = await supabase.fetch(
        DatabaseTableName.posts,
        fields,
      );

      final List<PostModel> loaded = [];

      for (var post in response) {
        post[DatabaseColumnName.image] = await supabase.publicUrl(
          StorageBucketName.postImages,
          "$userId/${post[DatabaseColumnName.image]}",
        );

        post[DatabaseTableName.userProfiles][DatabaseColumnName.image] =
            await supabase.publicUrl(
          StorageBucketName.userProfileImages,
          "$userId/${post[DatabaseTableName.userProfiles][DatabaseColumnName.image]}",
        );

        post[DatabaseColumnName.isLiked] = await isPostLiked(
          post[DatabaseColumnName.id],
        );

        loaded.add(PostModel.fromJson(post));
      }

      _list = loaded;
    } catch (e) {
      e.eLog();

      throw MessageException('error.failed_to_fetch_posts');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> add(PostModel post) async {
    try {
      _list.insert(0, post);
      notifyListeners();
    } catch (e) {
      e.eLog();

      throw MessageException('error.failed_to_add_post_to_post_list');
    }
  }

  Future<void> update(
    int id, {
    int? likeCount,
    int? commentCount,
    bool? isPostLiked,
  }) async {
    try {
      final index = _list.indexWhere(
        (e) => e.id == id,
      );

      _list[index] = _list[index].copyWith(
        likeCount: likeCount,
        isLiked: isPostLiked,
        commentCount: commentCount,
      );

      notifyListeners();
    } catch (e) {
      e.eLog();

      throw MessageException('error.failed_to_update_post_to_post_list');
    }
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
