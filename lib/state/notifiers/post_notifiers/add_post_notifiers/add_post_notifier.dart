import 'package:flutter/foundation.dart';

import '../../../../constants/database/database_column_name.dart';
import '../../../../constants/database/database_table_name.dart';
import '../../../../constants/database/storage_bucket_name.dart';
import '../../../../constants/extensions/file/get_file.dart';
import '../../../../constants/extensions/logger/logger_extension.dart';
import '../../../../models/post/create_post_model.dart';
import '../../../../models/post/post_model.dart';
import '../../../../services/supabase_service.dart';
import '../../../../utils/exceptions/message_exception.dart';
import '../../../../utils/storage/user_info.dart';

class AddPostNotifier extends ChangeNotifier {
  final supabase = SupabaseService();
  Future<PostModel> store(CreatePostModel post) async {
    try {
      final userId = await UserInfo.userId();

      if (post.image == null) {
        throw Exception('the given image is null!');
      }

      final image = post.image!;

      // Upload post image
      final path = await supabase.upload(
        StorageBucketName.postImages,
        '$userId/${image.getFileName}',
        image,
      );
      // Delete the generated image from device after upload
      image.delete();

      // Insert post data
      Map<String, dynamic> fields = {
        DatabaseColumnName.userId: userId,
        DatabaseColumnName.prompt: post.prompt,
        DatabaseColumnName.caption: post.caption,
        DatabaseColumnName.image: path.split('/').last,
      };
      final Map<String, dynamic> response = await supabase.insert(
        DatabaseTableName.posts,
        fields,
      );

      /// Replace user_id to user_profiles and get image public url
      final modifiedResponse = await _convertResponseToPostModel(response);

      return PostModel.fromJson(modifiedResponse);
    } on Exception catch (e) {
      e.eLog();
      throw MessageException('error.failed_to_add_post');
    }
  }

  Future<Map<String, dynamic>> _convertResponseToPostModel(
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
      StorageBucketName.postImages,
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
