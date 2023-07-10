import 'package:flutter/foundation.dart' show immutable;

import '../../constants/typedefs.dart';

@immutable
class ErrorController {
  final CloseLoadingScreen close;
  final UpdateLoadingScreen update;

  const ErrorController({
    required this.close,
    required this.update,
  });
}
