import 'package:flutter/cupertino.dart';

import 'AppLocalizations.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'fr', 'it', 'de', 'es', 'ja', 'ko']
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load(); // Load localized strings
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
