import 'package:flutter/material.dart';
import 'package:mobile_app/src/components/buttons/base_button_progress.dart';
import 'package:mobile_app/src/config/theme/app_radii.dart';
import 'package:mobile_app/src/config/theme/app_spacing.dart';
import 'package:mobile_app/src/config/theme/typography.dart';
import 'package:mobile_app/src/core/utils/extensions/context_x.dart';

class BaseOutlinedButton extends StatelessWidget {
  const BaseOutlinedButton._({
    super.key,
    required _BaseOutlinedButtonVariant variant,
    required this.onPressed,
    required this.label,
    this.icon,
    required this.expand,
    this.disabled = false,
    this.loading = false,
  }) : _variant = variant;

  factory BaseOutlinedButton.primary({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    IconData? icon,
    bool expand = true,
    bool disabled = false,
    bool loading = false,
  }) => BaseOutlinedButton._(
    key: key,
    variant: _BaseOutlinedButtonVariant.primary,
    onPressed: onPressed,
    label: label,
    icon: icon,
    expand: expand,
    disabled: disabled,
    loading: loading,
  );

  factory BaseOutlinedButton.secondary({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    IconData? icon,
    bool expand = false,
    bool disabled = false,
    bool loading = false,
  }) => BaseOutlinedButton._(
    key: key,
    variant: _BaseOutlinedButtonVariant.secondary,
    onPressed: onPressed,
    label: label,
    icon: icon,
    expand: expand,
    disabled: disabled,
    loading: loading,
  );

  final _BaseOutlinedButtonVariant _variant;
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
    return _variant == _BaseOutlinedButtonVariant.secondary
        ? s.secondary
        : s.primary;
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle? style = _variant == _BaseOutlinedButtonVariant.secondary
        ? _secondaryStyle(context)
        : null;

    final progress = baseButtonProgressIndicator(_progressColor(context));

    final Widget button = icon != null
        ? OutlinedButton.icon(
            onPressed: _effectiveOnPressed,
            style: style,
            icon: loading ? progress : Icon(icon),
            label: Text(label),
          )
        : OutlinedButton(
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
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return s.onSurface.withValues(alpha: 0.38);
        }
        return s.secondary;
      }),
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return BorderSide(color: s.onSurface.withValues(alpha: 0.12));
        }
        if (states.contains(WidgetState.focused)) {
          return BorderSide(color: s.secondary);
        }
        return BorderSide(color: s.outline);
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

enum _BaseOutlinedButtonVariant { primary, secondary }
