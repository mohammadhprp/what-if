import 'dart:io';

extension GetFile on File {
  String get getPath {
    return path;
  }

  String get getFileName {
    return getPath.split('/').last;
  }

  String get getFileExtension {
    return getFileName.split('.').last;
  }
}
