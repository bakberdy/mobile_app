// ignore_for_file: unintended_html_in_doc_comment

import 'package:flutter/material.dart';
import 'package:travel_app/src/config/theme/app_colors.dart';

/// Semantic color roles that extend Flutter's built-in ColorScheme.
///
/// Flutter's ColorScheme covers primary/secondary/tertiary/error.
/// This extension adds the missing semantic families:
///   success, warning, info
///
/// Each family follows the same M3 pattern:
///   base      — use for filled surfaces (buttons, badges, backgrounds)
///   onBase    — content drawn ON TOP of base (text, icons)
///   container — lower-emphasis tinted surface (chips, banners, cards)
///   onContainer — content drawn ON TOP of container
///
/// Access anywhere:
///   final t = Theme.of(context).extension<BaseThemeExtension>()!;
///   t.success           // filled button color
///   t.onSuccess         // text on filled button
///   t.successContainer  // chip / badge background
///   t.onSuccessContainer// text on chip / badge
@immutable
class BaseThemeExtension extends ThemeExtension<BaseThemeExtension> {
  const BaseThemeExtension({
    // Success
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    // Warning
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    // Info
    required this.info,
    required this.onInfo,
    required this.infoContainer,
    required this.onInfoContainer,
  });

  // Success
  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;

  // Warning
  final Color warning;
  final Color onWarning;
  final Color warningContainer;
  final Color onWarningContainer;

  // Info
  final Color info;
  final Color onInfo;
  final Color infoContainer;
  final Color onInfoContainer;

  // ── Presets ───────────────────────────────────────────────────────────────────

  /// Light theme — base colors are darker (40), containers are lighter (90)
  static const BaseThemeExtension light = BaseThemeExtension(
    success:            AppColors.success40,
    onSuccess:          AppColors.success100,
    successContainer:   AppColors.success90,
    onSuccessContainer: AppColors.success10,

    warning:            AppColors.warning40,
    onWarning:          AppColors.warning100,
    warningContainer:   AppColors.warning90,
    onWarningContainer: AppColors.warning10,

    info:            AppColors.info40,
    onInfo:          AppColors.info100,
    infoContainer:   AppColors.info90,
    onInfoContainer: AppColors.info10,
  );

  /// Dark theme — base colors are lighter (80), containers are darker (20)
  static const BaseThemeExtension dark = BaseThemeExtension(
    success:            AppColors.success80,
    onSuccess:          AppColors.success20,
    successContainer:   AppColors.success20,
    onSuccessContainer: AppColors.success90,

    warning:            AppColors.warning80,
    onWarning:          AppColors.warning20,
    warningContainer:   AppColors.warning20,
    onWarningContainer: AppColors.warning90,

    info:            AppColors.info80,
    onInfo:          AppColors.info20,
    infoContainer:   AppColors.info20,
    onInfoContainer: AppColors.info90,
  );

  // ── ThemeExtension API ────────────────────────────────────────────────────────

  @override
  BaseThemeExtension copyWith({
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? info,
    Color? onInfo,
    Color? infoContainer,
    Color? onInfoContainer,
  }) =>
      BaseThemeExtension(
        success:            success            ?? this.success,
        onSuccess:          onSuccess          ?? this.onSuccess,
        successContainer:   successContainer   ?? this.successContainer,
        onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
        warning:            warning            ?? this.warning,
        onWarning:          onWarning          ?? this.onWarning,
        warningContainer:   warningContainer   ?? this.warningContainer,
        onWarningContainer: onWarningContainer ?? this.onWarningContainer,
        info:               info               ?? this.info,
        onInfo:             onInfo             ?? this.onInfo,
        infoContainer:      infoContainer      ?? this.infoContainer,
        onInfoContainer:    onInfoContainer    ?? this.onInfoContainer,
      );

  @override
  BaseThemeExtension lerp(BaseThemeExtension? other, double t) {
    if (other == null) return this;
    return BaseThemeExtension(
      success:            Color.lerp(success,            other.success,            t)!,
      onSuccess:          Color.lerp(onSuccess,          other.onSuccess,          t)!,
      successContainer:   Color.lerp(successContainer,   other.successContainer,   t)!,
      onSuccessContainer: Color.lerp(onSuccessContainer, other.onSuccessContainer, t)!,
      warning:            Color.lerp(warning,            other.warning,            t)!,
      onWarning:          Color.lerp(onWarning,          other.onWarning,          t)!,
      warningContainer:   Color.lerp(warningContainer,   other.warningContainer,   t)!,
      onWarningContainer: Color.lerp(onWarningContainer, other.onWarningContainer, t)!,
      info:               Color.lerp(info,               other.info,               t)!,
      onInfo:             Color.lerp(onInfo,             other.onInfo,             t)!,
      infoContainer:      Color.lerp(infoContainer,      other.infoContainer,      t)!,
      onInfoContainer:    Color.lerp(onInfoContainer,    other.onInfoContainer,    t)!,
    );
  }
}
