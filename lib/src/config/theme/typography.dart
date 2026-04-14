import 'package:flutter/material.dart';

/// Material 3 type scale — all 15 roles.
///
/// Spec source: https://m3.material.io/styles/typography/type-scale-tokens
///
/// Colors are intentionally absent — Flutter applies ColorScheme colors
/// automatically at render time. Both themes share this single TextTheme.
///
/// To change a font family → edit the constants below.
/// To change a size/weight → edit the style directly.
/// To add a new style      → Flutter only supports the 15 roles below;
///                           for extras use a custom TextStyle in your widget.
class AppTypography {
  AppTypography._();

  // ── Font families ──────────────────────────────────────────────────────────
  static const String primary = 'Montserrat'; // used for all roles
  static const String display =
      'Hiatus'; // used only for displayLarge (hero/splash)

  // ── M3 Type scale ──────────────────────────────────────────────────────────
  //
  //  Role             Size   Weight   Height   LetterSpacing
  //  ─────────────────────────────────────────────────────────
  //  displayLarge      57     400      1.12      -0.25
  //  displayMedium     45     400      1.16       0.00
  //  displaySmall      36     400      1.22       0.00
  //  headlineLarge     32     400      1.25       0.00
  //  headlineMedium    28     400      1.29       0.00
  //  headlineSmall     24     400      1.33       0.00
  //  titleLarge        22     400      1.27       0.00
  //  titleMedium       16     500      1.50      +0.15
  //  titleSmall        14     500      1.43      +0.10
  //  labelLarge        14     500      1.43      +0.10
  //  labelMedium       12     500      1.33      +0.50
  //  labelSmall        11     500      1.45      +0.50
  //  bodyLarge         16     400      1.50      +0.50
  //  bodyMedium        14     400      1.43      +0.25
  //  bodySmall         12     400      1.33      +0.40
  //  ─────────────────────────────────────────────────────────

  static const TextTheme textTheme = TextTheme(
    // ── Display ──────────────────────────────────────────────────────────────
    // Large, expressive text. Typically used for hero or splash screens.
    displayLarge: TextStyle(
      fontFamily: display, // Hiatus for visual impact
      fontSize: 57,
      fontWeight: FontWeight.w400,
      height: 1.12,
      letterSpacing: -0.25,
    ),
    displayMedium: TextStyle(
      fontFamily: primary,
      fontSize: 45,
      fontWeight: FontWeight.w400,
      height: 1.16,
      letterSpacing: 0,
    ),
    displaySmall: TextStyle(
      fontFamily: primary,
      fontSize: 36,
      fontWeight: FontWeight.w400,
      height: 1.22,
      letterSpacing: 0,
    ),

    // ── Headline ─────────────────────────────────────────────────────────────
    // Section titles, screen headers, dialogs.
    headlineLarge: TextStyle(
      fontFamily: primary,
      fontSize: 32,
      fontWeight: FontWeight.w400,
      height: 1.25,
      letterSpacing: 0,
    ),
    headlineMedium: TextStyle(
      fontFamily: primary,
      fontSize: 28,
      fontWeight: FontWeight.w400,
      height: 1.29,
      letterSpacing: 0,
    ),
    headlineSmall: TextStyle(
      fontFamily: primary,
      fontSize: 24,
      fontWeight: FontWeight.w400,
      height: 1.33,
      letterSpacing: 0,
    ),

    // ── Title ─────────────────────────────────────────────────────────────────
    // AppBar titles, card titles, list item titles.
    titleLarge: TextStyle(
      fontFamily: primary,
      fontSize: 22,
      fontWeight: FontWeight.w400,
      height: 1.27,
      letterSpacing: 0,
    ),
    titleMedium: TextStyle(
      fontFamily: primary,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.50,
      letterSpacing: 0.15,
    ),
    titleSmall: TextStyle(
      fontFamily: primary,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.43,
      letterSpacing: 0.10,
    ),

    // ── Label ─────────────────────────────────────────────────────────────────
    // Buttons, tabs, chips, badges, navigation items.
    labelLarge: TextStyle(
      fontFamily: primary,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.43,
      letterSpacing: 0.10,
    ),
    labelMedium: TextStyle(
      fontFamily: primary,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.33,
      letterSpacing: 0.50,
    ),
    labelSmall: TextStyle(
      fontFamily: primary,
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 1.45,
      letterSpacing: 0.50,
    ),

    // ── Body ──────────────────────────────────────────────────────────────────
    // Main content, paragraphs, descriptions.
    bodyLarge: TextStyle(
      fontFamily: primary,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.50,
      letterSpacing: 0.50,
    ),
    bodyMedium: TextStyle(
      fontFamily: primary,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.43,
      letterSpacing: 0.25,
    ),
    bodySmall: TextStyle(
      fontFamily: primary,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.33,
      letterSpacing: 0.40,
    ),
  );
}
