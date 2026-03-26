import 'package:flutter/material.dart';

/// Color palette structured after the Material 3 color role system.
///
/// M3 organizes colors into role families — each family has a base color
/// and a paired "on" color (for content drawn on top of it).
///
/// Structure mirrors the M3 Design Kit:
///   https://m3.material.io/styles/color/roles
///
/// ┌─────────────────────────────────────────────────────────────────┐
/// │  HOW TO USE                                                     │
/// │  • To change a brand color → edit the palette section           │
/// │  • To tweak light/dark     → edit lightScheme / darkScheme      │
/// │  • To add a new role       → add to palette + both schemes      │
/// └─────────────────────────────────────────────────────────────────┘
class AppColors {
  AppColors._();

  // ════════════════════════════════════════════════════════════════════════════
  // RAW PALETTE — actual hex values, referenced by the schemes below
  // ════════════════════════════════════════════════════════════════════════════

  // ── Primary (Blue) ──────────────────────────────────────────────────────────
  static const Color primary10  = Color(0xff001A41);  // darkest
  static const Color primary20  = Color(0xff07285E);
  static const Color primary30  = Color(0xff163A78);
  static const Color primary40  = Color(0xff176EF1);  // main light primary
  static const Color primary80  = Color(0xff8AB4FF);  // main dark primary
  static const Color primary90  = Color(0xffD8E6FF);
  static const Color primary95  = Color(0xffF0F4FF);
  static const Color primary100 = Color(0xFFFFFFFF);

  // ── Secondary (Neutral Blue-Gray) ───────────────────────────────────────────
  static const Color secondary10  = Color(0xff0D1624);
  static const Color secondary20  = Color(0xff1B283A);
  static const Color secondary30  = Color(0xff2A3D55);
  static const Color secondary40  = Color(0xff3D5470);
  static const Color secondary80  = Color(0xffC1CAD8);
  static const Color secondary90  = Color(0xffDDE4EE);
  static const Color secondary95  = Color(0xffF3F8FE);  // light container
  static const Color secondary100 = Color(0xFFFFFFFF);

  // ── Tertiary (Accent — add your brand accent here) ──────────────────────────
  static const Color tertiary10  = Color(0xff2D1600);
  static const Color tertiary20  = Color(0xff4A2500);
  static const Color tertiary30  = Color(0xff6B3800);
  static const Color tertiary40  = Color(0xff8E4E00);
  static const Color tertiary80  = Color(0xffFFB870);
  static const Color tertiary90  = Color(0xffFFDCBC);
  static const Color tertiary95  = Color(0xffFFEEDD);
  static const Color tertiary100 = Color(0xFFFFFFFF);

  // ── Error ───────────────────────────────────────────────────────────────────
  static const Color error10  = Color(0xff3D0003);
  static const Color error20  = Color(0xff690005);
  static const Color error30  = Color(0xff93000A);
  static const Color error40  = Color(0xFFFF0000);  // light error
  static const Color error80  = Color(0xffFF8A80);  // dark error
  static const Color error90  = Color(0xffFFDAD6);
  static const Color error100 = Color(0xFFFFFFFF);

  // ── Surface / Neutral ───────────────────────────────────────────────────────
  static const Color neutral0   = Color(0xFF000000);
  static const Color neutral6   = Color(0xff0D1624);  // dark surface
  static const Color neutral10  = Color(0xff162235);
  static const Color neutral17  = Color(0xff1B283A);
  static const Color neutral20  = Color(0xff314057);
  static const Color neutral22  = Color(0xff162235);
  static const Color neutral24  = Color(0xff1E2E45);
  static const Color neutral87  = Color(0xffE0E5EB);
  static const Color neutral90  = Color(0xffF3F8FE);
  static const Color neutral92  = Color(0xffF5F7FA);
  static const Color neutral94  = Color(0xffF8FAFE);
  static const Color neutral95  = Color(0xffECF1FA);
  static const Color neutral96  = Color(0xffF0F4FF);
  static const Color neutral98  = Color(0xffFAFCFF);
  static const Color neutral100 = Color(0xFFFFFFFF);

  // ── Neutral Variant ─────────────────────────────────────────────────────────
  static const Color neutralVariant30 = Color(0xff314057);
  static const Color neutralVariant50 = Color(0xff96A5BD);
  static const Color neutralVariant60 = Color(0xffB8B8B8);
  static const Color neutralVariant80 = Color(0xffC8D0DC);
  static const Color neutralVariant90 = Color(0xffE0E5EB);

  // ── Success (Green) ──────────────────────────────────────────────────────────
  static const Color success10  = Color(0xff002106);
  static const Color success20  = Color(0xff00390e);
  static const Color success40  = Color(0xff1a7a2e);  // main light
  static const Color success80  = Color(0xff78dc77);  // main dark
  static const Color success90  = Color(0xffb7f4b3);  // light container
  static const Color success100 = Color(0xFFFFFFFF);

  // ── Warning (Amber) ──────────────────────────────────────────────────────────
  static const Color warning10  = Color(0xff2d1600);
  static const Color warning20  = Color(0xff4a2800);
  static const Color warning40  = Color(0xffb86200);  // main light
  static const Color warning80  = Color(0xffffb957);  // main dark
  static const Color warning90  = Color(0xffffddb3);  // light container
  static const Color warning100 = Color(0xFFFFFFFF);

  // ── Info (Cyan-Blue) ─────────────────────────────────────────────────────────
  static const Color info10  = Color(0xff001e2e);
  static const Color info20  = Color(0xff00344d);
  static const Color info40  = Color(0xff00658e);  // main light
  static const Color info80  = Color(0xff61d0ff);  // main dark
  static const Color info90  = Color(0xffb8e9ff);  // light container
  static const Color info100 = Color(0xFFFFFFFF);

  // ── Domain-specific (live in theme extensions, not ColorScheme) ──────────────
  static const Color difficultyEasy   = Color(0xff4CAF50);
  static const Color difficultyMedium = Color(0xffFF9800);
  static const Color difficultyHard   = Color(0xffF44336);

  // ════════════════════════════════════════════════════════════════════════════
  // LIGHT COLOR SCHEME  — maps M3 roles to palette values
  // ════════════════════════════════════════════════════════════════════════════
  //
  //  Role                      Palette ref       Purpose
  //  ─────────────────────────────────────────────────────────────────────────
  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,

    // Primary group
    primary:              primary40,   // main brand color
    onPrimary:            primary100,  // text/icons on primary
    primaryContainer:     primary90,   // lower-emphasis primary surfaces
    onPrimaryContainer:   primary10,   // text/icons on primaryContainer

    // Secondary group
    secondary:            secondary40, // less prominent brand color
    onSecondary:          secondary100,
    secondaryContainer:   secondary95, // light tinted container
    onSecondaryContainer: secondary10,

    // Tertiary group
    tertiary:             tertiary40,  // accent / contrasting role
    onTertiary:           tertiary100,
    tertiaryContainer:    tertiary90,
    onTertiaryContainer:  tertiary10,

    // Error group
    error:                error40,
    onError:              error100,
    errorContainer:       error90,
    onErrorContainer:     error10,

    // Surface group
    surface:              neutral100,  // main background
    onSurface:            neutral10,   // primary text
    surfaceContainerLowest:  neutral100,
    surfaceContainerLow:     neutral98,
    surfaceContainer:        neutral94,
    surfaceContainerHigh:    neutral92,
    surfaceContainerHighest: neutral90,

    // Surface variant / outline
    onSurfaceVariant:     neutralVariant60,
    outline:              neutralVariant90,
    outlineVariant:       neutralVariant80,

    // Inverse
    inverseSurface:       neutral20,
    onInverseSurface:     neutral95,
    inversePrimary:       primary80,

    // Misc
    shadow:               neutral0,
    scrim:                neutral0,
    surfaceTint:          primary40,
  );

  // ════════════════════════════════════════════════════════════════════════════
  // DARK COLOR SCHEME  — maps M3 roles to palette values
  // ════════════════════════════════════════════════════════════════════════════
  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,

    // Primary group
    primary:              primary80,
    onPrimary:            primary20,
    primaryContainer:     primary30,
    onPrimaryContainer:   primary90,

    // Secondary group
    secondary:            secondary80,
    onSecondary:          secondary20,
    secondaryContainer:   secondary30,
    onSecondaryContainer: secondary90,

    // Tertiary group
    tertiary:             tertiary80,
    onTertiary:           tertiary20,
    tertiaryContainer:    tertiary30,
    onTertiaryContainer:  tertiary90,

    // Error group
    error:                error80,
    onError:              error20,
    errorContainer:       error30,
    onErrorContainer:     error90,

    // Surface group
    surface:              neutral6,
    onSurface:            neutral92,
    surfaceContainerLowest:  neutral0,
    surfaceContainerLow:     neutral10,
    surfaceContainer:        neutral17,
    surfaceContainerHigh:    neutral22,
    surfaceContainerHighest: neutral24,

    // Surface variant / outline
    onSurfaceVariant:     neutralVariant50,
    outline:              neutralVariant30,
    outlineVariant:       neutralVariant50,

    // Inverse
    inverseSurface:       neutral90,
    onInverseSurface:     neutral20,
    inversePrimary:       primary40,

    // Misc
    shadow:               neutral0,
    scrim:                neutral0,
    surfaceTint:          primary80,
  );
}
