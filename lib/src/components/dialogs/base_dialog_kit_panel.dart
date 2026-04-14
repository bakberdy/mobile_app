import 'package:flutter/material.dart';
import 'package:mobile_app/src/components/buttons/base_filled_button.dart';
import 'package:mobile_app/src/components/buttons/base_outlined_button.dart';
import 'package:mobile_app/src/components/dialogs/dialog_kit_layout.dart';
import 'package:mobile_app/src/components/dialogs/dialog_kit_models.dart';
import 'package:mobile_app/src/core/utils/extensions/context_x.dart';

/// Shared column (header, body by [BaseDialogType], actions) for modal dialog and bottom sheet.
class BaseDialogKitPanel<T> extends StatefulWidget {
  const BaseDialogKitPanel({
    super.key,
    required this.hostContext,
    required this.expandActions,
    required this.type,
    this.title,
    this.description,
    required this.showClose,
    this.bodyText,
    this.body,
    this.checkboxLabel,
    this.checkboxItems,
    this.checkboxValue = false,
    this.onCheckboxChanged,
    this.onCheckboxesChanged,
    this.maxBodyHeight = 200,
    this.listItems,
    this.selectOptions,
    this.selectedIndex = 0,
    this.primaryLabel,
    this.onPrimary,
    this.onPrimaryWithIndex,
    this.secondaryLabel,
    this.onSecondary,
    required this.primaryFirst,
    required this.popOnAction,
  });

  /// [BuildContext] whose [Navigator] should receive [Navigator.pop] (sheet or dialog).
  final BuildContext hostContext;
  final bool expandActions;
  final BaseDialogType type;
  final String? title;
  final String? description;
  final bool showClose;
  final String? bodyText;
  final Widget? body;
  final String? checkboxLabel;
  final List<BaseDialogCheckboxItem>? checkboxItems;
  final bool checkboxValue;
  final ValueChanged<bool>? onCheckboxChanged;
  final ValueChanged<List<bool>>? onCheckboxesChanged;
  final double maxBodyHeight;
  final List<BaseDialogListItem>? listItems;
  final List<String>? selectOptions;
  final int selectedIndex;
  final String? primaryLabel;
  final VoidCallback? onPrimary;
  final void Function(int index)? onPrimaryWithIndex;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final bool primaryFirst;
  final bool popOnAction;

  @override
  State<BaseDialogKitPanel<T>> createState() => _BaseDialogKitPanelState<T>();
}

class _BaseDialogKitPanelState<T> extends State<BaseDialogKitPanel<T>> {
  late List<bool> _checkboxStates;
  late int _selected;

  @override
  void initState() {
    super.initState();
    if (widget.type == BaseDialogType.checkbox) {
      final items = widget.checkboxItems;
      if (items != null && items.isNotEmpty) {
        _checkboxStates = items.map((e) => e.value).toList();
      } else if (widget.checkboxLabel != null) {
        _checkboxStates = [widget.checkboxValue];
      } else {
        _checkboxStates = [];
      }
    } else {
      _checkboxStates = [];
    }
    _selected = widget.selectedIndex;
  }

  void _setCheckbox(int index, bool value) {
    if (index < 0 || index >= _checkboxStates.length) return;
    setState(() => _checkboxStates[index] = value);
    final copy = List<bool>.from(_checkboxStates);
    widget.onCheckboxesChanged?.call(copy);
    if (copy.length == 1) {
      widget.onCheckboxChanged?.call(copy.single);
    }
  }

  List<String> get _checkboxLabels {
    final items = widget.checkboxItems;
    if (items != null && items.isNotEmpty) {
      return items.map((e) => e.label).toList();
    }
    if (widget.checkboxLabel != null) {
      return [widget.checkboxLabel!];
    }
    return [];
  }

  void _pop([T? value]) {
    if (widget.hostContext.mounted) {
      Navigator.of(widget.hostContext).pop(value);
    }
  }

  void _onPrimary() {
    if (widget.onPrimaryWithIndex != null) {
      widget.onPrimaryWithIndex!(_selected);
    } else {
      widget.onPrimary?.call();
    }
    if (widget.popOnAction) {
      if (widget.type == BaseDialogType.select) {
        _pop(_selected as T?);
      } else if (widget.type == BaseDialogType.checkbox &&
          _checkboxStates.isNotEmpty) {
        _pop(List<bool>.from(_checkboxStates) as T?);
      } else {
        _pop();
      }
    }
  }

  void _onSecondary() {
    widget.onSecondary?.call();
    if (widget.popOnAction) _pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final titleStyle =
        theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: cs.onSurface,
        ) ??
        TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: cs.onSurface,
        );
    final descStyle =
        theme.textTheme.bodyMedium?.copyWith(
          color: cs.onSurfaceVariant,
          fontSize: 14,
        ) ??
        TextStyle(fontSize: 14, color: cs.onSurfaceVariant);
    final bodyStyle =
        theme.textTheme.bodyMedium?.copyWith(
          color: cs.onSurface,
          fontSize: 14,
          height: 1.4,
        ) ??
        TextStyle(fontSize: 14, height: 1.4, color: cs.onSurface);

    final hasHeader =
        widget.title != null || widget.description != null || widget.showClose;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (hasHeader)
          _DialogKitHeader(
            title: widget.title,
            description: widget.description,
            titleStyle: titleStyle,
            descStyle: descStyle,
            showClose: widget.showClose,
            onClose: () => _pop(),
          ),
        if (hasHeader) const SizedBox(height: DialogKitLayout.sectionGap),
        _buildMain(bodyStyle, cs),
        if (_hasFooter) ...[
          const SizedBox(height: DialogKitLayout.sectionGap),
          _DialogKitActionRow(
            expand: widget.expandActions,
            primaryFirst: widget.primaryFirst,
            secondaryLabel: widget.secondaryLabel,
            primaryLabel: widget.primaryLabel,
            onSecondary: widget.secondaryLabel != null ? _onSecondary : null,
            onPrimary: widget.primaryLabel != null ? _onPrimary : null,
          ),
        ],
      ],
    );
  }

  bool get _hasFooter =>
      widget.primaryLabel != null || widget.secondaryLabel != null;

  Widget _buildMain(TextStyle? bodyStyle, ColorScheme cs) {
    switch (widget.type) {
      case BaseDialogType.basic:
        return _basicBody(bodyStyle);
      case BaseDialogType.checkbox:
        final labels = _checkboxLabels;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            _basicBody(bodyStyle),
            if (labels.isNotEmpty)
              const SizedBox(height: DialogKitLayout.sectionGap),
            for (var i = 0; i < labels.length; i++) ...[
              if (i > 0) const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  if (i < _checkboxStates.length) {
                    _setCheckbox(i, !_checkboxStates[i]);
                  }
                },
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: i < _checkboxStates.length
                              ? _checkboxStates[i]
                              : false,
                          onChanged: (v) => _setCheckbox(i, v ?? false),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          activeColor: cs.primary,
                          side: BorderSide(color: cs.outline, width: 1.5),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          labels[i],
                          style: _themeBody(context, bodyStyle),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        );
      case BaseDialogType.scrollable:
        return _scrollableBody(bodyStyle);
      case BaseDialogType.list:
        return _listBody(bodyStyle);
      case BaseDialogType.select:
        return _selectBody(cs, bodyStyle);
    }
  }

  TextStyle? _themeBody(BuildContext context, TextStyle? bodyStyle) =>
      bodyStyle ?? Theme.of(context).textTheme.bodyMedium;

  Widget _basicBody(TextStyle? bodyStyle) {
    if (widget.body != null) return widget.body!;
    if (widget.bodyText != null) {
      return Text(widget.bodyText!, style: bodyStyle);
    }
    return const SizedBox.shrink();
  }

  Widget _scrollableBody(TextStyle? bodyStyle) {
    final child =
        widget.body ??
        (widget.bodyText != null
            ? Text(widget.bodyText!, style: bodyStyle)
            : const SizedBox.shrink());

    return ClipRect(
      child: SizedBox(
        height: widget.maxBodyHeight,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: child,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 40,
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(
                          context,
                        ).colorScheme.surface.withValues(alpha: 0),
                        Theme.of(context).colorScheme.surface,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listBody(TextStyle? bodyStyle) {
    final items = widget.listItems ?? const <BaseDialogListItem>[];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(height: 18),
          InkWell(
            onTap: items[i].onTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (items[i].leading != null)
                    SizedBox(width: 60, height: 60, child: items[i].leading)
                  else
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      child: Text(
                        items[i].title.isNotEmpty
                            ? items[i].title[0].toUpperCase()
                            : '?',
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          items[i].title,
                          style: bodyStyle?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (items[i].subtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(items[i].subtitle!, style: bodyStyle),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _selectBody(ColorScheme cs, TextStyle? bodyStyle) {
    final options = widget.selectOptions ?? const <String>[];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < options.length; i++) ...[
          if (i > 0) const SizedBox(height: 18),
          InkWell(
            onTap: () => setState(() => _selected = i),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    // ignore: deprecated_member_use
                    child: Radio<int>(
                      value: i,
                      // ignore: deprecated_member_use
                      groupValue: _selected,
                      // ignore: deprecated_member_use
                      onChanged: (v) {
                        if (v != null) setState(() => _selected = v);
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      activeColor: cs.primary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      options[i],
                      style: _themeBody(context, bodyStyle),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _DialogKitHeader extends StatelessWidget {
  const _DialogKitHeader({
    this.title,
    this.description,
    required this.titleStyle,
    this.descStyle,
    required this.showClose,
    required this.onClose,
  });

  final String? title;
  final String? description;
  final TextStyle titleStyle;
  final TextStyle? descStyle;
  final bool showClose;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) Text(title!, style: titleStyle),
              if (description != null) ...[
                if (title != null) const SizedBox(height: 4),
                Text(description!, style: descStyle),
              ],
            ],
          ),
        ),
        if (showClose) ...[
          const SizedBox(width: DialogKitLayout.sectionGap),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close_rounded, size: 24),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
            visualDensity: VisualDensity.compact,
            style: IconButton.styleFrom(
              foregroundColor: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

class _DialogKitActionRow extends StatelessWidget {
  const _DialogKitActionRow({
    required this.expand,
    required this.primaryFirst,
    this.secondaryLabel,
    this.primaryLabel,
    this.onSecondary,
    this.onPrimary,
  });

  final bool expand;
  final bool primaryFirst;
  final String? secondaryLabel;
  final String? primaryLabel;
  final VoidCallback? onSecondary;
  final VoidCallback? onPrimary;

  @override
  Widget build(BuildContext context) {
    final gap = expand ? 8.0 : 16.0;
    final secondary = secondaryLabel != null
        ? BaseOutlinedButton.primary(
            onPressed: onSecondary,
            label: secondaryLabel!,
            expand: expand,
          )
        : null;
    final primary = primaryLabel != null
        ? BaseFilledButton.primary(
            onPressed: onPrimary,
            label: primaryLabel!,
            expand: expand,
          )
        : null;

    if (secondary != null && primary != null) {
      final first = primaryFirst ? primary : secondary;
      final second = primaryFirst ? secondary : primary;
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (expand) Expanded(child: first) else first,
          SizedBox(width: gap),
          if (expand) Expanded(child: second) else second,
        ],
      );
    }
    if (primary != null) {
      if (expand) {
        return Row(children: [Expanded(child: primary)]);
      }
      return Row(mainAxisAlignment: MainAxisAlignment.end, children: [primary]);
    }
    if (secondary != null) {
      if (expand) {
        return Row(children: [Expanded(child: secondary)]);
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [secondary],
      );
    }
    return const SizedBox.shrink();
  }
}
