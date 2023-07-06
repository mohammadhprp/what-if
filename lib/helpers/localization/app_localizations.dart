import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'app_localizations_delegate.dart';

class AppLocalizations {
  late Locale locale;
  final Map<String, String> _valueText = {};
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of(context, AppLocalizations);
  }

  static List<Locale> locales = [const Locale('en')];

  static bool isSupported(Locale locale) {
    return locales.contains(locale);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  Future loadTranslateFile() async {
    String langFile = await rootBundle.loadString(
      'assets/lang/${locale.languageCode}.json',
    );

    Map<String, dynamic> json = jsonDecode(langFile);
    json.forEach((key, value) {
      if (value is Map) {
        value.forEach((k, v) {
          _valueText['$key.$k'] = v.toString();
        });
      } else {
        _valueText[key] = value.toString();
      }
    });
  }

  String getTranslate(String key) {
    return _valueText[key] ?? key;
  }
}
