import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../constants/database/database_column_name.dart';
import '../../../../constants/database/database_table_name.dart';
import '../../../../constants/database/local_storage_name.dart';
import '../../../../constants/database/storage_bucket_name.dart';
import '../../../../constants/extensions/file/get_file.dart';
import '../../../../constants/extensions/logger/logger_extension.dart';
import '../../../../helpers/storage/local_storage.dart' as lg;
import '../../../../models/post/create_post_model.dart';
import '../../../../models/post/post_model.dart';
import '../../../../utils/exceptions/message_exception.dart';
import '../../../../utils/storage/user_info.dart';

class AddPostNotifier extends ChangeNotifier {
  Future<PostModel> store(CreatePostModel post) async {
    // create a post
    try {
      final supabase = Supabase.instance.client;

      final userId = await lg.LocalStorage.get(key: LocalStorageName.userId);

      final image = post.image!;

      // Upload post image
      final path = await supabase.storage
          .from(StorageBucketName.postImages)
          .upload('$userId/${image.getFileName}', image);

      // Insert post data
      Map<String, dynamic> fields = {
        DatabaseColumnName.userId: userId,
        DatabaseColumnName.prompt: post.prompt,
        DatabaseColumnName.caption: post.caption,
        DatabaseColumnName.image: path,
      };

      final Map<String, dynamic> response = await supabase
          .from(DatabaseTableName.posts)
          .insert(fields)
          .select()
          .single();

      // Delete the generated image from device
      image.delete();

      /// Replace user_id to user_profiles
      // Convert the map into a list
      List<MapEntry<String, dynamic>> responseList = response.entries.toList();
      // Find and re  move the entry with the key "user_id"
      responseList
          .removeWhere((entry) => entry.key == DatabaseColumnName.userId);
      final currentUserProfile = await UserInfo.profile();

      // Add a new entry with the key "user_profiles"
      responseList.add(MapEntry(
        DatabaseTableName.userProfiles,
        currentUserProfile.toJson(),
      ));
      // Convert the list back into a map
      final modifiedResponse = Map.fromEntries(responseList);

      return PostModel.fromJson(modifiedResponse);
    } on Exception catch (e) {
      e.eLog();
      throw MessageException('error.failed_to_add_post');
    }
  }
}
