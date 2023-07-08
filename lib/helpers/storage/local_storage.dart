import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  /// Store the [key] with the given [value].
  static void store({required String key, required dynamic value}) async {
    const FlutterSecureStorage storage = FlutterSecureStorage();

    await storage.write(key: key, value: "$value");
  }

  /// Get the value for the given [key].
  static Future<String?> get({required String key}) async {
    const FlutterSecureStorage storage = FlutterSecureStorage();

    final value = await storage.read(key: key);

    return value;
  }

  /// Delete the [value] with the given [key].
  static void delete({required String key}) async {
    const FlutterSecureStorage storage = FlutterSecureStorage();

    await storage.delete(key: key);
  }

  // Check the value exist by the given [key]
  static Future<bool> isExist({required String key}) async {
    const FlutterSecureStorage storage = FlutterSecureStorage();

    final value = await storage.read(key: key);

    return value != null;
  }
}
