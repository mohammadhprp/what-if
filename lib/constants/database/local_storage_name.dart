import 'package:flutter/foundation.dart' show immutable;

@immutable
class LocalStorageName {
  static const token = 'token';
  static const refreshToken = 'refresh_token';
  static const userId = 'user_id';
  static const userName = 'user_name';
  static const email = 'email';

  const LocalStorageName._();
}
