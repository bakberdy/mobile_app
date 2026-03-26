import 'package:flutter/material.dart';
import 'package:mobile_app/src/config/theme/app_colors.dart';
import 'package:mobile_app/src/config/theme/base_theme_x.dart';
import 'package:mobile_app/src/config/theme/extensions/route_theme_extension.dart';
import 'package:mobile_app/src/config/theme/typography.dart';

/// Assembles the full ThemeData from the building blocks.
///
/// Color role mapping follows M3 spec:
///   https://m3.material.io/styles/color/roles
///
/// To change colors            → edit AppColors
/// To change fonts/sizes       → edit AppTypography
/// To add semantic colors      → edit BaseThemeExtension
/// To add domain extensions    → add a file under theme/extensions/
/// To add a component theme    → add it inside _build()
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => _build(
        AppColors.lightScheme,
        BaseThemeExtension.light,
        RouteThemeExtension.light,
      );

  static ThemeData get darkTheme => _build(
        AppColors.darkScheme,
        BaseThemeExtension.dark,
        RouteThemeExtension.dark,
      );

  static ThemeData _build(
    ColorScheme s,
    BaseThemeExtension base,
    RouteThemeExtension route,
  ) =>
      ThemeData(
        useMaterial3: true,
        colorScheme: s,
        textTheme: AppTypography.textTheme,
        scaffoldBackgroundColor: s.surface,
        extensions: [base, route],

        // ── AppBar ────────────────────────────────────────────────────────────
        // surface background, onSurface icons/title, no elevation by default
        appBarTheme: AppBarTheme(
          backgroundColor: s.surface,
          foregroundColor: s.onSurface,
          surfaceTintColor: s.surfaceTint,
          shadowColor: s.shadow,
          elevation: 0,
          scrolledUnderElevation: 1,
          centerTitle: false,
          titleTextStyle: AppTypography.textTheme.titleLarge?.copyWith(
            color: s.onSurface,
          ),
          iconTheme: IconThemeData(color: s.onSurface),
          actionsIconTheme: IconThemeData(color: s.onSurfaceVariant),
        ),

        // ── Bottom Navigation Bar (M2-style, kept for compatibility) ──────────
        // selected → primary / unselected → onSurfaceVariant (M3 spec)
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: s.surface,
          elevation: 0,
          enableFeedback: false,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedIconTheme: IconThemeData(color: s.primary),
          unselectedIconTheme: IconThemeData(color: s.onSurfaceVariant),
          selectedLabelStyle: AppTypography.textTheme.labelMedium?.copyWith(
            color: s.primary,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: AppTypography.textTheme.labelMedium?.copyWith(
            color: s.onSurfaceVariant,
          ),
        ),

        // ── Navigation Bar (M3-style) ─────────────────────────────────────────
        // surfaceContainer background, indicator uses secondaryContainer
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: s.surfaceContainer,
          surfaceTintColor: s.surfaceTint,
          indicatorColor: s.secondaryContainer,
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return IconThemeData(color: s.onSecondaryContainer);
            }
            return IconThemeData(color: s.onSurfaceVariant);
          }),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final base = AppTypography.textTheme.labelMedium!;
            if (states.contains(WidgetState.selected)) {
              return base.copyWith(color: s.onSurface, fontWeight: FontWeight.w600);
            }
            return base.copyWith(color: s.onSurfaceVariant);
          }),
        ),

        // ── Filled Button ─────────────────────────────────────────────────────
        // primary background, onPrimary content
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return s.onSurface.withValues(alpha: 0.12);
              }
              return s.primary;
            }),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return s.onSurface.withValues(alpha: 0.38);
              }
              return s.onPrimary;
            }),
            overlayColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                return s.onPrimary.withValues(alpha: 0.12);
              }
              if (states.contains(WidgetState.hovered)) {
                return s.onPrimary.withValues(alpha: 0.08);
              }
              return null;
            }),
            textStyle: WidgetStateProperty.all(
              AppTypography.textTheme.labelLarge?.copyWith(
                fontFamily: AppTypography.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),

        // ── Elevated Button ───────────────────────────────────────────────────
        // surfaceContainerLow background, primary content, tinted shadow
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return s.onSurface.withValues(alpha: 0.12);
              }
              return s.surfaceContainerLow;
            }),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return s.onSurface.withValues(alpha: 0.38);
              }
              return s.primary;
            }),
            overlayColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                return s.primary.withValues(alpha: 0.12);
              }
              if (states.contains(WidgetState.hovered)) {
                return s.primary.withValues(alpha: 0.08);
              }
              return null;
            }),
            shadowColor: WidgetStateProperty.all(s.shadow),
            surfaceTintColor: WidgetStateProperty.all(s.surfaceTint),
            textStyle: WidgetStateProperty.all(
              AppTypography.textTheme.labelLarge?.copyWith(
                fontFamily: AppTypography.primary,
              ),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),

        // ── Outlined Button ───────────────────────────────────────────────────
        // transparent background, outline border, primary content
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return s.onSurface.withValues(alpha: 0.38);
              }
              return s.primary;
            }),
            side: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return BorderSide(color: s.onSurface.withValues(alpha: 0.12));
              }
              if (states.contains(WidgetState.focused)) {
                return BorderSide(color: s.primary);
              }
              return BorderSide(color: s.outline);
            }),
            overlayColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                return s.primary.withValues(alpha: 0.12);
              }
              if (states.contains(WidgetState.hovered)) {
                return s.primary.withValues(alpha: 0.08);
              }
              return null;
            }),
            textStyle: WidgetStateProperty.all(
              AppTypography.textTheme.labelLarge?.copyWith(
                fontFamily: AppTypography.primary,
              ),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),

        // ── Text Button ───────────────────────────────────────────────────────
        // no background, primary content
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return s.onSurface.withValues(alpha: 0.38);
              }
              return s.primary;
            }),
            overlayColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                return s.primary.withValues(alpha: 0.12);
              }
              if (states.contains(WidgetState.hovered)) {
                return s.primary.withValues(alpha: 0.08);
              }
              return null;
            }),
            textStyle: WidgetStateProperty.all(
              AppTypography.textTheme.labelLarge?.copyWith(
                fontFamily: AppTypography.primary,
              ),
            ),
          ),
        ),

        // ── Icon Button ───────────────────────────────────────────────────────
        // onSurfaceVariant icons
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return s.onSurface.withValues(alpha: 0.38);
              }
              return s.onSurfaceVariant;
            }),
            overlayColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                return s.onSurfaceVariant.withValues(alpha: 0.12);
              }
              if (states.contains(WidgetState.hovered)) {
                return s.onSurfaceVariant.withValues(alpha: 0.08);
              }
              return null;
            }),
          ),
        ),

        // ── FAB ───────────────────────────────────────────────────────────────
        // primaryContainer background, onPrimaryContainer icon
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: s.primaryContainer,
          foregroundColor: s.onPrimaryContainer,
          elevation: 3,
          focusElevation: 4,
          hoverElevation: 4,
          highlightElevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),

        // ── Input / Text field ────────────────────────────────────────────────
        // outline uses outline color, focused border uses primary
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: s.surfaceContainerHighest,
          hintStyle: AppTypography.textTheme.bodyLarge?.copyWith(
            color: s.onSurfaceVariant,
          ),
          labelStyle: AppTypography.textTheme.bodyLarge?.copyWith(
            color: s.onSurfaceVariant,
          ),
          floatingLabelStyle: AppTypography.textTheme.bodySmall?.copyWith(
            color: s.primary,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: s.outline),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: s.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: s.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: s.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: s.error, width: 2),
          ),
          errorStyle: AppTypography.textTheme.bodySmall?.copyWith(
            color: s.error,
          ),
        ),

        // ── Card ──────────────────────────────────────────────────────────────
        // surfaceContainerLow background, subtle shadow
        cardTheme: CardThemeData(
          color: s.surfaceContainerLow,
          shadowColor: s.shadow,
          surfaceTintColor: Colors.transparent,
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: EdgeInsets.zero,
        ),

        // ── Chip ──────────────────────────────────────────────────────────────
        // secondaryContainer background, onSecondaryContainer text
        chipTheme: ChipThemeData(
          backgroundColor: s.secondaryContainer,
          labelStyle: AppTypography.textTheme.labelLarge?.copyWith(
            color: s.onSecondaryContainer,
          ),
          side: BorderSide(color: s.outline),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          selectedColor: s.primaryContainer,
          checkmarkColor: s.onPrimaryContainer,
        ),

        // ── Dialog ────────────────────────────────────────────────────────────
        // surfaceContainerHigh background
        dialogTheme: DialogThemeData(
          backgroundColor: s.surfaceContainerHigh,
          surfaceTintColor: Colors.transparent,
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          titleTextStyle: AppTypography.textTheme.headlineSmall?.copyWith(
            color: s.onSurface,
          ),
          contentTextStyle: AppTypography.textTheme.bodyMedium?.copyWith(
            color: s.onSurfaceVariant,
          ),
        ),

        // ── Bottom Sheet ──────────────────────────────────────────────────────
        // surfaceContainerLow background
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: s.surfaceContainerLow,
          surfaceTintColor: Colors.transparent,
          elevation: 1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          dragHandleColor: s.onSurfaceVariant,
        ),

        // ── Snack Bar ─────────────────────────────────────────────────────────
        // inverseSurface background, onInverseSurface text (always high contrast)
        snackBarTheme: SnackBarThemeData(
          backgroundColor: s.inverseSurface,
          contentTextStyle: AppTypography.textTheme.bodyMedium?.copyWith(
            color: s.onInverseSurface,
          ),
          actionTextColor: s.inversePrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          behavior: SnackBarBehavior.floating,
        ),

        // ── Divider ───────────────────────────────────────────────────────────
        // outlineVariant — subtle, not as strong as outline
        dividerTheme: DividerThemeData(
          color: s.outlineVariant,
          thickness: 1,
          space: 1,
        ),

        // ── Switch ────────────────────────────────────────────────────────────
        // selected track → primary, thumb → onPrimary
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return s.onPrimary;
            return s.onSurfaceVariant;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return s.primary;
            return s.surfaceContainerHighest;
          }),
          trackOutlineColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return Colors.transparent;
            return s.outline;
          }),
        ),

        // ── Checkbox ──────────────────────────────────────────────────────────
        // checked → primary, border → outline
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return s.primary;
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(s.onPrimary),
          side: BorderSide(color: s.outline, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),

        // ── Radio ─────────────────────────────────────────────────────────────
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return s.primary;
            return s.onSurfaceVariant;
          }),
        ),

        // ── Slider ────────────────────────────────────────────────────────────
        // active → primary, inactive → surfaceContainerHighest
        sliderTheme: SliderThemeData(
          activeTrackColor: s.primary,
          inactiveTrackColor: s.surfaceContainerHighest,
          thumbColor: s.primary,
          overlayColor: s.primary.withValues(alpha: 0.12),
          valueIndicatorColor: s.primaryContainer,
          valueIndicatorTextStyle: AppTypography.textTheme.labelMedium?.copyWith(
            color: s.onPrimaryContainer,
          ),
        ),

        // ── Progress indicator ────────────────────────────────────────────────
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: s.primary,
          linearTrackColor: s.surfaceContainerHighest,
          circularTrackColor: s.surfaceContainerHighest,
        ),

        // ── Tab bar ───────────────────────────────────────────────────────────
        // selected label → primary, indicator → primary
        tabBarTheme: TabBarThemeData(
          labelColor: s.primary,
          unselectedLabelColor: s.onSurfaceVariant,
          indicatorColor: s.primary,
          labelStyle: AppTypography.textTheme.titleSmall?.copyWith(
            fontFamily: AppTypography.primary,
          ),
          unselectedLabelStyle: AppTypography.textTheme.titleSmall?.copyWith(
            fontFamily: AppTypography.primary,
          ),
          dividerColor: s.outlineVariant,
        ),

        // ── List tile ─────────────────────────────────────────────────────────
        listTileTheme: ListTileThemeData(
          tileColor: Colors.transparent,
          iconColor: s.onSurfaceVariant,
          textColor: s.onSurface,
          titleTextStyle: AppTypography.textTheme.bodyLarge?.copyWith(
            color: s.onSurface,
          ),
          subtitleTextStyle: AppTypography.textTheme.bodyMedium?.copyWith(
            color: s.onSurfaceVariant,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      );
}
