import 'dart:async';
import 'package:flutter/material.dart';
import 'localization.dart';

class LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const LocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['it', 'en'].contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) async {
    Localization localizations = new Localization(locale);
    await localizations.load();

    return localizations;
  }

  @override
  bool shouldReload(LocalizationDelegate old) => false;
}