import 'package:flutter/material.dart';
import 'package:mobile_app/src/components/buttons/base_button_progress.dart';
import 'package:mobile_app/src/config/theme/app_radii.dart';
import 'package:mobile_app/src/config/theme/app_spacing.dart';
import 'package:mobile_app/src/config/theme/typography.dart';
import 'package:mobile_app/src/core/utils/extensions/context_x.dart';

class BaseElevatedButton extends StatelessWidget {
  const BaseElevatedButton._({
    super.key,
    required _BaseElevatedButtonVariant variant,
    required this.onPressed,
    required this.label,
    this.icon,
    required this.expand,
    this.disabled = false,
    this.loading = false,
  }) : _variant = variant;

  factory BaseElevatedButton.primary({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    IconData? icon,
    bool expand = true,
    bool disabled = false,
    bool loading = false,
  }) => BaseElevatedButton._(
    key: key,
    variant: _BaseElevatedButtonVariant.primary,
    onPressed: onPressed,
    label: label,
    icon: icon,
    expand: expand,
    disabled: disabled,
    loading: loading,
  );

  factory BaseElevatedButton.secondary({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    IconData? icon,
    bool expand = false,
    bool disabled = false,
    bool loading = false,
  }) => BaseElevatedButton._(
    key: key,
    variant: _BaseElevatedButtonVariant.secondary,
    onPressed: onPressed,
    label: label,
    icon: icon,
    expand: expand,
    disabled: disabled,
    loading: loading,
  );

  final _BaseElevatedButtonVariant _variant;
  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final bool expand;
  final bool disabled;
  final bool loading;

  VoidCallback? get _effectiveOnPressed =>
      (loading || disabled) ? null : onPressed;

  Color _progressColor(BuildContext context) {
    final s = context.colorScheme;
    return _variant == _BaseElevatedButtonVariant.secondary
        ? s.secondary
        : s.primary;
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle? style = _variant == _BaseElevatedButtonVariant.secondary
        ? _secondaryStyle(context)
        : null;

    final progress = baseButtonProgressIndicator(_progressColor(context));

    final Widget button = icon != null
        ? ElevatedButton.icon(
            onPressed: _effectiveOnPressed,
            style: style,
            icon: loading ? progress : Icon(icon),
            label: Text(label),
          )
        : ElevatedButton(
            onPressed: _effectiveOnPressed,
            style: style,
            child: loading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      progress,
                      const SizedBox(width: AppSpacing.xs),
                      Text(label),
                    ],
                  )
                : Text(label),
          );

    if (expand) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }

  static ButtonStyle _secondaryStyle(BuildContext context) {
    final s = context.colorScheme;
    return ButtonStyle(
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
        return s.secondary;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return s.secondary.withValues(alpha: 0.12);
        }
        if (states.contains(WidgetState.hovered)) {
          return s.secondary.withValues(alpha: 0.08);
        }
        return null;
      }),
      shadowColor: WidgetStateProperty.all(s.shadow),
      surfaceTintColor: WidgetStateProperty.all(s.secondary),
      textStyle: WidgetStateProperty.all(
        AppTypography.textTheme.labelLarge?.copyWith(
          fontFamily: AppTypography.primary,
        ),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
        ),
      ),
    );
  }
}

enum _BaseElevatedButtonVariant { primary, secondary }
