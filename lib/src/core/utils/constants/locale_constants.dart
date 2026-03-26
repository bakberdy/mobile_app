import 'package:flutter/material.dart';

class LocaleConstants {
  LocaleConstants._();

  static const Locale english = Locale('en');
  static const Locale russian = Locale('ru');
  static const Locale kazakh = Locale('kk');

  static const List<Locale> supportedLocales = [
    english,
    russian,
    kazakh,
  ];

  static const Locale defaultLocale = english;
}
