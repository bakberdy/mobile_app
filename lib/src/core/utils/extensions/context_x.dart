import 'package:flutter/material.dart';
import 'package:mobile_app/gen/assets.gen.dart';
import 'package:mobile_app/src/config/theme/base_theme_x.dart';
import 'package:mobile_app/src/core/language/generated/app_localizations.dart';

extension ContextExtensions on BuildContext {

  //theme extensions
  ThemeData get theme => Theme.of(this);  
  TextTheme get textTheme => TextTheme.of(this);
  ColorScheme get colorScheme => ColorScheme.of(this);
  BaseThemeExtension get baseThemeX => theme.extension<BaseThemeExtension>()!;

  //locale extensions
  AppLocalizations get l10n => AppLocalizations.of(this);
  Locale get locale => Localizations.localeOf(this);
  AppContextAssets get assets => const AppContextAssets();
  bool get isRTL {
    final languageCode = locale.languageCode;
    return ['ar', 'he', 'fa', 'ur'].contains(languageCode);
  }
  String get languageCode => locale.languageCode;

  
}

final class AppContextAssets {
  const AppContextAssets();

  $AssetsIconsGen get icons => AppAssets.icons;
  $AssetsImagesGen get images => AppAssets.images;
}