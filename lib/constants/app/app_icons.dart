import 'package:flutter/foundation.dart' show immutable;

@immutable
class AppIcons {
  static const _path = 'assets/icons';

  static const google = '$_path/google-logo.svg';
  static const facebook = '$_path/facebook-logo.svg';
  static const github = '$_path/github-logo.svg';

  static const closeCircle = '$_path/close-circle.svg';
  static const infoCircle = '$_path/info-circle.svg';

  const AppIcons._();
}
