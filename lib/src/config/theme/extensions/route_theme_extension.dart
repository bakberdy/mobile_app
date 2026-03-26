// ignore_for_file: unintended_html_in_doc_comment

import 'package:flutter/material.dart';
import 'package:mobile_app/src/config/theme/app_colors.dart';

/// Domain-specific colors for route difficulty levels.
///
/// Follows the same M3 role pattern as BaseThemeExtension:
///   base      — filled chip / badge background
///   onBase    — text/icon on top of base
///
/// Access anywhere:
///   final t = Theme.of(context).extension<RouteThemeExtension>()!;
///   t.easy            // chip background for easy routes
///   t.onEasy          // label color on that chip
@immutable
class RouteThemeExtension extends ThemeExtension<RouteThemeExtension> {
  const RouteThemeExtension({
    required this.easy,
    required this.onEasy,
    required this.medium,
    required this.onMedium,
    required this.hard,
    required this.onHard,
  });

  final Color easy;
  final Color onEasy;
  final Color medium;
  final Color onMedium;
  final Color hard;
  final Color onHard;

  // ── Presets ───────────────────────────────────────────────────────────────────

  static const RouteThemeExtension light = RouteThemeExtension(
    easy:     AppColors.difficultyEasy,
    onEasy:   AppColors.success100,
    medium:   AppColors.difficultyMedium,
    onMedium: AppColors.warning100,
    hard:     AppColors.difficultyHard,
    onHard:   AppColors.error100,
  );

  static const RouteThemeExtension dark = RouteThemeExtension(
    easy:     AppColors.difficultyEasy,
    onEasy:   AppColors.success100,
    medium:   AppColors.difficultyMedium,
    onMedium: AppColors.warning100,
    hard:     AppColors.difficultyHard,
    onHard:   AppColors.error100,
  );

  // ── ThemeExtension API ────────────────────────────────────────────────────────

  @override
  RouteThemeExtension copyWith({
    Color? easy,
    Color? onEasy,
    Color? medium,
    Color? onMedium,
    Color? hard,
    Color? onHard,
  }) =>
      RouteThemeExtension(
        easy:     easy     ?? this.easy,
        onEasy:   onEasy   ?? this.onEasy,
        medium:   medium   ?? this.medium,
        onMedium: onMedium ?? this.onMedium,
        hard:     hard     ?? this.hard,
        onHard:   onHard   ?? this.onHard,
      );

  @override
  RouteThemeExtension lerp(RouteThemeExtension? other, double t) {
    if (other == null) return this;
    return RouteThemeExtension(
      easy:     Color.lerp(easy,     other.easy,     t)!,
      onEasy:   Color.lerp(onEasy,   other.onEasy,   t)!,
      medium:   Color.lerp(medium,   other.medium,   t)!,
      onMedium: Color.lerp(onMedium, other.onMedium, t)!,
      hard:     Color.lerp(hard,     other.hard,     t)!,
      onHard:   Color.lerp(onHard,   other.onHard,   t)!,
    );
  }
}
