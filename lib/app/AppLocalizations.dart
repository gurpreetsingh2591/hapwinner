import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  late Map<String, String> _localizedStrings;

  Future<void> load() async {
    if (kDebugMode) {
      print("apply lang--$locale");
    }
    String jsonString =
    await rootBundle.loadString('assets/l10n/app_${locale.languageCode}.arb');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) =>
        MapEntry(key, value.toString()));

    if (kDebugMode) {
      print("_localizedStrings--$_localizedStrings");
    }// Convert dynamic values to strings
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key; // Return key if not found
  }
}
