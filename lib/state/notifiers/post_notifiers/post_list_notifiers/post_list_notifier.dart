import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../constants/database/database_column_name.dart';
import '../../../../constants/database/database_table_name.dart';
import '../../../../constants/extensions/logger/logger_extension.dart';
import '../../../../constants/typedefs.dart';
import '../../../../models/post/post_model.dart';

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
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
