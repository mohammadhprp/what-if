import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:what_if/helpers/storage/local_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    FlutterSecureStorage.setMockInitialValues({});
  });

  test('store then get value by given key', () async {
    const key = 'token';
    const token = 'US-2234';
    LocalStorage.store(key: key, value: token);

    final value = await LocalStorage.get(key: key);

    expect(value, equals(token));
  });

  test('delete value by given key', () async {
    const key = 'token';
    const token = 'US-2234';
    LocalStorage.store(key: key, value: token);

    LocalStorage.delete(key: key);

    final value = await LocalStorage.isExist(key: key);

    expect(value, equals(false));
  });

  test('isExist() return true if value if given key exist', () async {
    const key = 'token';
    const token = 'US-2234';
    LocalStorage.store(key: key, value: token);

    final value = await LocalStorage.isExist(key: key);

    expect(value, equals(true));
  });

  test('isExist() return false if value if given key not exist', () async {
    final unknownValue = await LocalStorage.isExist(key: 'unknown_key');

    expect(unknownValue, equals(false));
  });
}
