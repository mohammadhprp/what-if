import 'package:flutter/material.dart';

import '../../../constants/database/database_column_name.dart';
import '../../../constants/database/database_table_name.dart';
import '../../../constants/database/storage_bucket_name.dart';
import '../../../constants/extensions/logger/logger_extension.dart';
import '../../../constants/typedefs.dart';
import '../../../models/story/story_model.dart';
import '../../../services/supabase_service.dart';
import '../../../utils/exceptions/message_exception.dart';
import '../../../utils/storage/user_info.dart';

class StoryListNotifier extends ChangeNotifier {
  IsLoading _isLoading = false;
  IsLoading get isLoading => _isLoading;

  List<StoryModel> _list = [];
  List<StoryModel> get list => _list;

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
        ${DatabaseColumnName.image}, 
        ${DatabaseColumnName.createdAt}
      """;

      final List response = await supabase.fetch(
        DatabaseTableName.stories,
        fields,
      );

      final List<StoryModel> loaded = [];

      for (var story in response) {
        story[DatabaseColumnName.image] = await supabase.publicUrl(
          StorageBucketName.storyImages,
          "$userId/${story[DatabaseColumnName.image]}",
        );

        story[DatabaseTableName.userProfiles][DatabaseColumnName.image] =
            await supabase.publicUrl(
          StorageBucketName.userProfileImages,
          "$userId/${story[DatabaseTableName.userProfiles][DatabaseColumnName.image]}",
        );

        loaded.add(StoryModel.fromJson(story));
      }

      _list = loaded;
    } catch (e) {
      e.eLog();

      throw MessageException('error.failed_to_fetch_stories');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> add(StoryModel story) async {
    try {
      _list.insert(0, story);
      notifyListeners();
    } catch (e) {
      e.eLog();
      throw MessageException('error.failed_to_add_story_to_story_list');
    }
  }
}
