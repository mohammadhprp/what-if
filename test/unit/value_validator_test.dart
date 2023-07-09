import 'package:flutter_test/flutter_test.dart';
import 'package:what_if/utils/validator/value_validator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('validate email with a valid and an invalid email ', () async {
    final invalidEmail = ValueValidator.email(email: 'domain.com');

    expect(invalidEmail, equals(false));

    final validEmail = ValueValidator.email(email: 'example@domain.com');

    expect(validEmail, equals(true));
  });

  test('validate passwords with valid and invalid password', () async {
    final passwordWithoutUpperCaseChar = ValueValidator.password(
      password: 'as@a1234',
    );
    expect(passwordWithoutUpperCaseChar, equals(false));

    final passwordWithoutLowerCaseChar = ValueValidator.password(
      password: 'AS@A1234',
    );
    expect(passwordWithoutLowerCaseChar, equals(false));

    final passwordWithoutDigit = ValueValidator.password(
      password: 'AW@asdfr',
    );
    expect(passwordWithoutDigit, equals(false));

    final passwordWithoutSpecialChar = ValueValidator.password(
      password: 'ASeA1234',
    );
    expect(passwordWithoutSpecialChar, equals(false));

    final passwordWithLessThenEightChar = ValueValidator.password(
      password: 'As@a123',
    );
    expect(passwordWithLessThenEightChar, equals(false));

    final validPassword = ValueValidator.password(password: 'hE263%LS');
    expect(validPassword, equals(true));
  });
}
