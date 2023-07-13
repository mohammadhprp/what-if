import 'package:flutter/foundation.dart' show immutable;

import '../../constants/typedefs.dart';

@immutable
class ToastMessageController {
  final CloseLoadingScreen close;

  const ToastMessageController({
    required this.close,
  });
}
