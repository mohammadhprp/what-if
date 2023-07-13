import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../../constants/extensions/file/get_file.dart';

@immutable
class LocalDirectory {
  const LocalDirectory();

  /// Store file by given name
  static Future<void> store({
    required String dir,
    required File file,
  }) async {
    final String path = await _path();

    await file.copy("$path/$dir/${file.getFileName}");
  }

  /// Store file by given name
  static Future<void> storeFromBytes({
    required String name,
    required String dir,
    required Uint8List file,
  }) async {
    final String path = await _path();
    final newFile = await File("$path/$dir/$name").create(recursive: true);
    await newFile.writeAsBytes(file);
  }

  /// Get file by given name
  static Future<File> get({
    required String dir,
    required String? name,
  }) async {
    if (name == null) {
      Exception('File path is null');
    }
    final String path = await _path();

    final file = File("$path/$dir/$name");
    return file;
  }

  /// Delete file by given name
  static Future<void> delete({
    required String dir,
    required String? name,
  }) async {
    if (name == null) return;

    final String path = await _path();

    final file = File("$path/$dir/$name");
    await file.delete();
  }

  /// Check if is exists by given name
  static Future<bool> isExist({
    required String dir,
    required String? name,
  }) async {
    if (name == null) return false;

    final String path = await _path();

    final file = File("$path/$dir/$name");

    return await file.exists();
  }

  /// Get local directory path
  static Future<String> _path() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final String path = appDocumentsDir.path;

    return path;
  }
}
