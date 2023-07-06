import 'package:flutter/cupertino.dart';

import 'app_localizations.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.locales.contains(locale);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalizations = AppLocalizations(locale);
    await appLocalizations.loadTranslateFile();
    return appLocalizations;
  }

  @override
  bool shouldReload(covariant AppLocalizationsDelegate old) => false;
}
