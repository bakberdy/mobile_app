import 'package:flutter/material.dart';
import 'package:mobile_app/src/components/buttons/base_button_progress.dart';
import 'package:mobile_app/src/core/utils/extensions/context_x.dart';

class BaseIconButton extends StatelessWidget {
  const BaseIconButton._({
    super.key,
    required _BaseIconButtonVariant variant,
    required this.icon,
    this.selectedIcon,
    this.isSelected = false,
    required this.onPressed,
    this.tooltip,
    this.disabled = false,
    this.loading = false,
  }) : _variant = variant;

  factory BaseIconButton.standard({
    Key? key,
    required Widget icon,
    Widget? selectedIcon,
    bool isSelected = false,
    required VoidCallback? onPressed,
    String? tooltip,
    bool disabled = false,
    bool loading = false,
  }) =>
      BaseIconButton._(
        key: key,
        variant: _BaseIconButtonVariant.standard,
        icon: icon,
        selectedIcon: selectedIcon,
        isSelected: isSelected,
        onPressed: onPressed,
        tooltip: tooltip,
        disabled: disabled,
        loading: loading,
      );

  factory BaseIconButton.primary({
    Key? key,
    required Widget icon,
    Widget? selectedIcon,
    bool isSelected = false,
    required VoidCallback? onPressed,
    String? tooltip,
    bool disabled = false,
    bool loading = false,
  }) =>
      BaseIconButton._(
        key: key,
        variant: _BaseIconButtonVariant.primary,
        icon: icon,
        selectedIcon: selectedIcon,
        isSelected: isSelected,
        onPressed: onPressed,
        tooltip: tooltip,
        disabled: disabled,
        loading: loading,
      );

  factory BaseIconButton.secondary({
    Key? key,
    required Widget icon,
    Widget? selectedIcon,
    bool isSelected = false,
    required VoidCallback? onPressed,
    String? tooltip,
    bool disabled = false,
    bool loading = false,
  }) =>
      BaseIconButton._(
        key: key,
        variant: _BaseIconButtonVariant.secondary,
        icon: icon,
        selectedIcon: selectedIcon,
        isSelected: isSelected,
        onPressed: onPressed,
        tooltip: tooltip,
        disabled: disabled,
        loading: loading,
      );

  final _BaseIconButtonVariant _variant;
  final Widget icon;
  final Widget? selectedIcon;
  final bool isSelected;
  final VoidCallback? onPressed;
  final String? tooltip;
  final bool disabled;
  final bool loading;

  VoidCallback? get _effectiveOnPressed =>
      (loading || disabled) ? null : onPressed;

  Color _progressColor(BuildContext context) {
    final s = context.colorScheme;
    return switch (_variant) {
      _BaseIconButtonVariant.standard => s.onSurfaceVariant,
      _BaseIconButtonVariant.primary => s.primary,
      _BaseIconButtonVariant.secondary => s.secondary,
    };
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle? style = switch (_variant) {
      _BaseIconButtonVariant.standard => null,
      _BaseIconButtonVariant.primary => _coloredStyle(context, isPrimary: true),
      _BaseIconButtonVariant.secondary =>
        _coloredStyle(context, isPrimary: false),
    };

    final progress = baseButtonProgressIndicator(_progressColor(context));

    return IconButton(
      icon: loading ? progress : icon,
      selectedIcon: loading ? progress : selectedIcon,
      isSelected: isSelected,
      onPressed: _effectiveOnPressed,
      tooltip: tooltip,
      style: style,
    );
  }

  static ButtonStyle _coloredStyle(
    BuildContext context, {
    required bool isPrimary,
  }) {
    final s = context.colorScheme;
    final Color normal = isPrimary ? s.primary : s.secondary;
    return ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return s.onSurface.withValues(alpha: 0.38);
        }
        return normal;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return normal.withValues(alpha: 0.12);
        }
        if (states.contains(WidgetState.hovered)) {
          return normal.withValues(alpha: 0.08);
        }
        return null;
      }),
    );
  }
}

enum _BaseIconButtonVariant { standard, primary, secondary }
