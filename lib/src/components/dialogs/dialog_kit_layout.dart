import 'package:flutter/material.dart';
import 'package:mobile_app/src/config/theme/app_radii.dart';
import 'package:mobile_app/src/config/theme/app_spacing.dart';

/// Shared layout tokens for [BaseDialog] and [BaseBottomSheet] (Figma kit).
abstract final class DialogKitLayout {
  static const double padding = AppSpacing.lg;
  static const double cornerRadius = AppRadii.xl;
  static const double sectionGap = AppSpacing.lg;

  /// Applied to [ColorScheme.scrim] when modals omit an explicit barrier color.
  static const double barrierScrimOpacity = 0.54;

  /// Applied to [ColorScheme.shadow] for the centered dialog card drop shadow.
  static const double dialogShadowOpacity = 0.28;

  static Color modalBarrierColor(BuildContext context, Color? override) {
    if (override != null) return override;
    final s = Theme.of(context).colorScheme;
    return s.scrim.withValues(alpha: barrierScrimOpacity);
  }

  static List<BoxShadow> dialogCardShadows(ColorScheme scheme) => [
    BoxShadow(
      color: scheme.shadow.withValues(alpha: dialogShadowOpacity),
      offset: const Offset(0, 5),
      blurRadius: 16,
    ),
  ];
}
