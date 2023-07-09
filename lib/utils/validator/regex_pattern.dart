class RegexPattern {
  static final RegExp email = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+",
  );
  static RegExp upperCase = RegExp(r'[A-Z]');
  static RegExp lowerCase = RegExp(r'[a-z]');
  static RegExp digit = RegExp(r'\d');
  static RegExp specialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
}
