import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/database/local_storage_name.dart';
import '../../../constants/enums/auth_result.dart';
import '../../../constants/typedefs.dart';
import '../../../helpers/storage/local_storage.dart';
import '../../../models/auth/auth_state.dart';
import '../../../utils/exceptions/message_exception.dart';
import '../../backend/auth/authenticator.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    state = state.copyWithIsLoading(true);

    final result = await _authenticator.signUpWithEmail(
      email: email,
      password: password,
      name: name,
    );

    final userId = _authenticator.userId;
    final token = _authenticator.token;
    final refreshToken = _authenticator.refreshToken;

    if (result == AuthResult.success &&
        userId != null &&
        token != null &&
        refreshToken != null) {
      await saveUserInfo(
        token: token,
        refreshToken: refreshToken,
        userId: userId,
        email: email,
      );
    }

    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );

    if (result == AuthResult.failure) {
      throw MessageException('error.an_account_with_email_already_exist');
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWithIsLoading(true);

    final result = await _authenticator.signInWithEmail(
      email: email,
      password: password,
    );

    final userId = _authenticator.userId;
    final token = _authenticator.token;
    final refreshToken = _authenticator.refreshToken;

    if (result == AuthResult.success &&
        userId != null &&
        token != null &&
        refreshToken != null) {
      await saveUserInfo(
        token: token,
        refreshToken: refreshToken,
        userId: userId,
        email: email,
      );
    }

    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );

    if (result == AuthResult.failure) {
      throw MessageException('error.invalid_email_or_password');
    }
  }

  Future<void> signOut() async {
    state = state.copyWithIsLoading(true);
    await _authenticator.signOut();
    state = const AuthState.unknown();
    LocalStorage.deleteAll();
  }

  Future<void> saveUserInfo({
    required Token token,
    required Token refreshToken,
    required UserId userId,
    required String email,
  }) async {
    LocalStorage.store(key: LocalStorageName.token, value: token);
    LocalStorage.store(key: LocalStorageName.refreshToken, value: refreshToken);
    LocalStorage.store(key: LocalStorageName.userId, value: userId);
    LocalStorage.store(key: LocalStorageName.email, value: email);
  }
}
