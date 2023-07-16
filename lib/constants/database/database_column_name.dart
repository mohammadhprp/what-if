import 'package:flutter/foundation.dart' show immutable;

@immutable
class DatabaseColumnName {
  static const id = 'id';
  static const user = 'user';
  static const userId = 'user_id';
  static const profileId = 'profile_id';
  static const userName = 'user_name';
  static const name = 'name';
  static const email = 'email';
  static const image = 'image';
  static const prompt = 'prompt';
  static const caption = 'caption';
  static const likeCount = 'like_count';
  static const commentCount = 'comment_count';
  static const createdAt = 'created_at';

  const DatabaseColumnName._();
}
