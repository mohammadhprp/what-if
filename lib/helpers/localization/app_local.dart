import 'package:flutter/material.dart';

import 'app_localizations.dart';

class AppLocal {
  static String tr(BuildContext context, String key) {
    return AppLocalizations.of(context).getTranslate(key);
  }
}
