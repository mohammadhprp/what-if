import 'dart:io';

import 'package:flutter/material.dart';

import '../../../constants/database/database_column_name.dart';
import '../../../constants/database/database_table_name.dart';
import '../../../constants/database/storage_bucket_name.dart';
import '../../../constants/extensions/file/get_file.dart';
import '../../../models/story/story_model.dart';
import '../../../services/supabase_service.dart';
import '../../../utils/storage/user_info.dart';

class AddStoryNotifier extends ChangeNotifier {
  final supabase = SupabaseService();

  Future<StoryModel> store(File image) async {
    final userId = await UserInfo.userId();

    // Upload story image
    final path = await supabase.upload(
      StorageBucketName.storyImages,
      '$userId/${image.getFileName}',
      image,
    );

    // Insert story data
    Map<String, dynamic> fields = {
      DatabaseColumnName.userId: userId,
      DatabaseColumnName.image: path.split('/').last,
    };

    final Map<String, dynamic> response = await supabase.insert(
      DatabaseTableName.stories,
      fields,
    );

    /// Replace user_id to user_profiles and get image public url
    final modifiedResponse = await _convertResponseToStoryModel(response);

    return StoryModel.fromJson(modifiedResponse);
  }

  Future<Map<String, dynamic>> _convertResponseToStoryModel(
    Map<String, dynamic> response,
  ) async {
    final userId = await UserInfo.userId();
    // Convert the map into a list
    List<MapEntry<String, dynamic>> responseList = response.entries.toList();
    // Find and re  move the entry with the key "user_id"
    responseList.removeWhere(
      (entry) => entry.key == DatabaseColumnName.userId,
    );

    final imageUrl = supabase.publicUrl(
      StorageBucketName.storyImages,
      "$userId/${response[DatabaseColumnName.image]}",
    );

    response.update(
      DatabaseColumnName.image,
      (value) => imageUrl,
    );

    // Add a new entry with the key "user_profiles"
    final currentUserProfile = await UserInfo.profile();
    responseList.add(MapEntry(
      DatabaseTableName.userProfiles,
      currentUserProfile.toJson(),
    ));
    // Convert the list back into a map
    final modifiedResponse = Map.fromEntries(responseList);

    return modifiedResponse;
  }
}
