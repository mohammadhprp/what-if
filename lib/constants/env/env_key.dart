import 'package:flutter/material.dart';

@immutable
class EnvKey {
  static const supabaseUrl = 'SUPABASE_URL';
  static const supabaseAnonKey = 'SUPABASE_ANON_KEY';

  static const masterApiBearerToken = 'MASTER_API_BEARER_TOKEN';
  static const masterApiXApiKey = 'MASTER_API_X_API_KEY';

  const EnvKey._();
}
