import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../constants/database/database_column_name.dart';
import '../../../../constants/database/database_table_name.dart';
import '../../../../constants/extensions/logger/logger_extension.dart';
import '../../../../constants/typedefs.dart';
import '../../../../models/post/post_model.dart';
import '../../../../utils/exceptions/message_exception.dart';

class PostListNotifier extends ChangeNotifier {
  IsLoading _isLoading = false;
  IsLoading get isLoading => _isLoading;
  List<PostModel> _list = [];
  List<PostModel> get list => _list;

  Future<void> fetch() async {
    try {
      _isLoading = true;
      final supabase = Supabase.instance.client;

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

      final List response = await supabase
          .from(DatabaseTableName.posts)
          .select(fields)
          .order(DatabaseColumnName.createdAt);

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
