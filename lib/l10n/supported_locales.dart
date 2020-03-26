import 'package:flutter/widgets.dart';

const locales = <String>['en'];
List<Locale> get supportedLocales =>
    locales.map((locale) => Locale(locale, '')).toList();
