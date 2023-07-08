import 'package:flutter/foundation.dart' show immutable;

import '../../constants/typedefs.dart';

@immutable
class LoadingController {
  final CloseLoadingScreen close;
  final UpdateLoadingScreen update;

  const LoadingController({
    required this.close,
    required this.update,
  });
}
