import 'package:flutter/foundation.dart' show immutable;

@immutable
class DatabaseTableName {
  static const userProfiles = 'user_profiles';
  static const posts = 'posts';
  static const stories = 'stories';
  static const postLikes = 'post_likes';
  static const followers = 'followers';

  const DatabaseTableName._();
}
