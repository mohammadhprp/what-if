import 'package:flutter/foundation.dart' show immutable;

@immutable
class StorageBucketName {
  static const userProfileImages = 'user_profile_images';
  static const postImages = 'post_images';
  static const storyImages = 'story_images';

  const StorageBucketName._();
}
