import 'package:flutter/material.dart';
import 'package:mobile_app/src/components/buttons/base_button_progress.dart';
import 'package:mobile_app/src/config/theme/app_radii.dart';
import 'package:mobile_app/src/config/theme/app_spacing.dart';
import 'package:mobile_app/src/config/theme/typography.dart';
import 'package:mobile_app/src/core/utils/extensions/context_x.dart';

class BaseFilledButton extends StatelessWidget {
  const BaseFilledButton._({
    super.key,
    required _BaseFilledButtonVariant variant,
    required this.onPressed,
    required this.label,
    this.icon,
    required this.expand,
    this.disabled = false,
    this.loading = false,
  }) : _variant = variant;

  factory BaseFilledButton.primary({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    IconData? icon,
    bool expand = true,
    bool disabled = false,
    bool loading = false,
  }) => BaseFilledButton._(
    key: key,
    variant: _BaseFilledButtonVariant.primary,
    onPressed: onPressed,
    label: label,
    icon: icon,
    expand: expand,
    disabled: disabled,
    loading: loading,
  );

  factory BaseFilledButton.secondary({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    IconData? icon,
    bool expand = false,
    bool disabled = false,
    bool loading = false,
  }) => BaseFilledButton._(
    key: key,
    variant: _BaseFilledButtonVariant.secondary,
    onPressed: onPressed,
    label: label,
    icon: icon,
    expand: expand,
    disabled: disabled,
    loading: loading,
  );

  final _BaseFilledButtonVariant _variant;
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
    return _variant == _BaseFilledButtonVariant.secondary
        ? s.onSecondary
        : s.onPrimary;
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle? style = _variant == _BaseFilledButtonVariant.secondary
        ? _secondaryStyle(context)
        : null;

    final Widget button = icon != null
        ? FilledButton.icon(
            onPressed: _effectiveOnPressed,
            style: style,
            icon: loading
                ? baseButtonProgressIndicator(_progressColor(context))
                : Icon(icon),
            label: Text(label),
          )
        : FilledButton(
            onPressed: _effectiveOnPressed,
            style: style,
            child: loading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      baseButtonProgressIndicator(_progressColor(context)),
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
        return s.secondary;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return s.onSurface.withValues(alpha: 0.38);
        }
        return s.onSecondary;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return s.onSecondary.withValues(alpha: 0.12);
        }
        if (states.contains(WidgetState.hovered)) {
          return s.onSecondary.withValues(alpha: 0.08);
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
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
        ),
      ),
    );
  }
}

enum _BaseFilledButtonVariant { primary, secondary }
