import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/auth/auth_state.dart';
import '../../notifiers/auth_notifiers/auth_state_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (_) => AuthStateNotifier(),
);
