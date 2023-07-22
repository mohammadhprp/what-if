import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../constants/database/database_column_name.dart';
import '../../../../constants/database/database_table_name.dart';
import '../../../../constants/database/local_storage_name.dart';
import '../../../../constants/database/storage_bucket_name.dart';
import '../../../../constants/extensions/file/get_file.dart';
import '../../../../helpers/storage/local_storage.dart' as lg;
import '../../../../models/post/create_post_model.dart';

class AddPostNotifier extends ChangeNotifier {
  Future<void> store(CreatePostModel post) async {
    // create a post
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

    await supabase.from(DatabaseTableName.posts).insert(fields);

    // Delete the generated image from device
    image.delete();
  }
}
