import 'package:bloom/utils/hive_manager.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  bool isRTL = false;

  dynamic test;

  setTest(dynamic newTest){
    test = newTest;
    notifyListeners();
  }

  Locale get locale => _locale;

  LocaleProvider(){
    String localeCode = HiveStorageManager.getLocale();
    _locale = Locale(localeCode);
    isRTL = _locale.languageCode == "ar";
  }

  void setLocale(Locale locale) {
    if (!AppLocalizations.supportedLocales.contains(locale)) return;
    _locale = locale;
    HiveStorageManager.setLocale(_locale.languageCode);
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale('en');
    HiveStorageManager.setLocale('en');
    notifyListeners();
  }
}