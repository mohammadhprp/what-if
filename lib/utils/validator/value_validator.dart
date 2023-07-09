import 'regex_pattern.dart';

class ValueValidator {
  static bool email({required String email}) {
    RegExp emailRegex = RegexPattern.email;
    return emailRegex.hasMatch(email.trim());
  }

  static bool password({required String password}) {
    const int minLength = 8;
    if (!RegexPattern.upperCase.hasMatch(password)) {
      return false;
    }
    if (!RegexPattern.lowerCase.hasMatch(password)) {
      return false;
    }
    if (!RegexPattern.digit.hasMatch(password)) {
      return false;
    }
    if (!RegexPattern.specialChar.hasMatch(password)) {
      return false;
    }
    if (password.length < minLength) {
      return false;
    }

    return true;
  }
}
