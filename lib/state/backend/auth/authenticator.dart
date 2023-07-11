import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../constants/database/database_column_name.dart';
import '../../../constants/enums/auth_result.dart';
import '../../../constants/typedefs.dart';

class Authenticator {
  const Authenticator();

  Token? get token => Supabase.instance.client.auth.currentSession?.accessToken;
  Token? get refreshToken =>
      Supabase.instance.client.auth.currentSession?.refreshToken;
  UserId? get userId => Supabase.instance.client.auth.currentUser?.id;
  String? get email => Supabase.instance.client.auth.currentUser?.email;

  bool get isAlreadyLoggedIn => userId != null;

  Future<AuthResult> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final supabase = Supabase.instance.client;

      final res = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {DatabaseColumnName.userName: name},
      );

      if (res.session == null || res.user == null) {
        return AuthResult.failure;
      }

      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  Future<AuthResult> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final supabase = Supabase.instance.client;

      final res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (res.session == null || res.user == null) {
        return AuthResult.failure;
      }

      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  Future<void> signOut() async {
    final supabase = Supabase.instance.client;
    await supabase.auth.signOut();
  }
}
