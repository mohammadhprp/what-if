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
  IsLoading _isLoading = false;
  IsLoading get isLoading => _isLoading;
  List<PostModel> _list = [];
  List<PostModel> get list => _list;

  Future<void> fetch() async {
    try {
      final userId = await UserInfo.userId();

      _isLoading = true;

      final supabase = SupabaseService();

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
}
