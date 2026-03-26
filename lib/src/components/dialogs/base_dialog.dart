import 'package:flutter/material.dart';
import 'package:mobile_app/src/components/dialogs/base_dialog_kit_panel.dart';
import 'package:mobile_app/src/components/dialogs/dialog_kit_layout.dart';
import 'package:mobile_app/src/components/dialogs/dialog_kit_models.dart';
import 'package:mobile_app/src/core/utils/extensions/context_x.dart';

export 'dialog_kit_models.dart';

/// Centered modal dialogs from the Figma kit. For sheets use [BaseBottomSheet].
///
/// Prefer [show] with [BaseDialogType], or shortcuts like [showBasic].
class BaseDialog {
  BaseDialog._();

  static const double _maxWidth = 384;

  static Future<T?> showBasic<T>(
    BuildContext context, {
    String? title,
    String? description,
    bool showClose = true,
    String? bodyText,
    Widget? body,
    String? primaryLabel,
    VoidCallback? onPrimary,
    String? secondaryLabel,
    VoidCallback? onSecondary,
    bool primaryFirst = false,
    bool barrierDismissible = true,
    Color? barrierColor,
    bool popOnAction = true,
  }) {
    return show<T>(
      context,
      type: BaseDialogType.basic,
      title: title,
      description: description,
      showClose: showClose,
      bodyText: bodyText,
      body: body,
      primaryLabel: primaryLabel,
      onPrimary: onPrimary,
      secondaryLabel: secondaryLabel,
      onSecondary: onSecondary,
      primaryFirst: primaryFirst,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      popOnAction: popOnAction,
    );
  }

  static Future<T?> showCheckbox<T>(
    BuildContext context, {
    String? title,
    String? description,
    bool showClose = true,
    String? bodyText,
    Widget? body,
    String? checkboxLabel,
    List<BaseDialogCheckboxItem>? checkboxItems,
    bool checkboxValue = false,
    ValueChanged<bool>? onCheckboxChanged,
    ValueChanged<List<bool>>? onCheckboxesChanged,
    String? primaryLabel,
    VoidCallback? onPrimary,
    String? secondaryLabel,
    VoidCallback? onSecondary,
    bool primaryFirst = false,
    bool barrierDismissible = true,
    Color? barrierColor,
    bool popOnAction = true,
  }) {
    assert(
      checkboxLabel != null ||
          (checkboxItems != null && checkboxItems.isNotEmpty),
    );
    return show<T>(
      context,
      type: BaseDialogType.checkbox,
      title: title,
      description: description,
      showClose: showClose,
      bodyText: bodyText,
      body: body,
      checkboxLabel: checkboxLabel,
      checkboxItems: checkboxItems,
      checkboxValue: checkboxValue,
      onCheckboxChanged: onCheckboxChanged,
      onCheckboxesChanged: onCheckboxesChanged,
      primaryLabel: primaryLabel,
      onPrimary: onPrimary,
      secondaryLabel: secondaryLabel,
      onSecondary: onSecondary,
      primaryFirst: primaryFirst,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      popOnAction: popOnAction,
    );
  }

  static Future<T?> showScrollable<T>(
    BuildContext context, {
    String? title,
    String? description,
    bool showClose = true,
    String? bodyText,
    Widget? body,
    double maxBodyHeight = 200,
    String? primaryLabel,
    VoidCallback? onPrimary,
    String? secondaryLabel,
    VoidCallback? onSecondary,
    bool primaryFirst = false,
    bool barrierDismissible = true,
    Color? barrierColor,
    bool popOnAction = true,
  }) {
    return show<T>(
      context,
      type: BaseDialogType.scrollable,
      title: title,
      description: description,
      showClose: showClose,
      bodyText: bodyText,
      body: body,
      maxBodyHeight: maxBodyHeight,
      primaryLabel: primaryLabel,
      onPrimary: onPrimary,
      secondaryLabel: secondaryLabel,
      onSecondary: onSecondary,
      primaryFirst: primaryFirst,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      popOnAction: popOnAction,
    );
  }

  static Future<T?> showList<T>(
    BuildContext context, {
    String? title,
    String? description,
    bool showClose = true,
    required List<BaseDialogListItem> items,
    String? primaryLabel,
    VoidCallback? onPrimary,
    String? secondaryLabel,
    VoidCallback? onSecondary,
    bool primaryFirst = false,
    bool barrierDismissible = true,
    Color? barrierColor,
    bool popOnAction = true,
  }) {
    return show<T>(
      context,
      type: BaseDialogType.list,
      title: title,
      description: description,
      showClose: showClose,
      listItems: items,
      primaryLabel: primaryLabel,
      onPrimary: onPrimary,
      secondaryLabel: secondaryLabel,
      onSecondary: onSecondary,
      primaryFirst: primaryFirst,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      popOnAction: popOnAction,
    );
  }

  static Future<int?> showSelect(
    BuildContext context, {
    String? title,
    String? description,
    bool showClose = true,
    required List<String> options,
    int selectedIndex = 0,
    String? primaryLabel,
    void Function(int index)? onPrimary,
    String? secondaryLabel,
    VoidCallback? onSecondary,
    bool primaryFirst = false,
    bool barrierDismissible = true,
    Color? barrierColor,
    bool popOnAction = true,
  }) {
    return show<int>(
      context,
      type: BaseDialogType.select,
      title: title,
      description: description,
      showClose: showClose,
      selectOptions: options,
      selectedIndex: selectedIndex,
      primaryLabel: primaryLabel,
      onPrimaryWithIndex: onPrimary,
      secondaryLabel: secondaryLabel,
      onSecondary: onSecondary,
      primaryFirst: primaryFirst,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      popOnAction: popOnAction,
    );
  }

  /// Full-screen route (not in the Figma card kit). For long text, legal, or onboarding.
  static Future<T?> showFullscreen<T>(
    BuildContext context, {
    String? title,
    String? bodyText,
    Widget? body,
    String? primaryLabel,
    VoidCallback? onPrimary,
    String? secondaryLabel,
    VoidCallback? onSecondary,
    bool primaryFirst = false,
    bool barrierDismissible = false,
    Color? barrierColor,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierDismissible ? context.l10n.dismiss : null,
      barrierColor: DialogKitLayout.modalBarrierColor(context, barrierColor),
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (_, animation, _, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: child,
        );
      },
      pageBuilder: (dialogContext, _, _) {
        final theme = Theme.of(dialogContext);
        final effectiveContent = body ??
            (bodyText != null
                ? Text(bodyText, style: theme.dialogTheme.contentTextStyle)
                : null);

        return PopScope(
          canPop: barrierDismissible,
          child: Dialog.fullscreen(
            child: Scaffold(
              appBar: AppBar(
                title: title != null ? Text(title) : null,
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (effectiveContent != null)
                        Expanded(
                          child: SingleChildScrollView(child: effectiveContent),
                        )
                      else
                        const Spacer(),
                      const SizedBox(height: 16),
                      _FullscreenActionRow(
                        dialogContext: dialogContext,
                        primaryLabel: primaryLabel,
                        primaryOnPressed: onPrimary,
                        secondaryLabel: secondaryLabel,
                        secondaryOnPressed: onSecondary,
                        primaryFirst: primaryFirst,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<T?> show<T>(
    BuildContext context, {
    required BaseDialogType type,
    String? title,
    String? description,
    bool showClose = true,
    String? bodyText,
    Widget? body,
    String? checkboxLabel,
    List<BaseDialogCheckboxItem>? checkboxItems,
    bool checkboxValue = false,
    ValueChanged<bool>? onCheckboxChanged,
    ValueChanged<List<bool>>? onCheckboxesChanged,
    double maxBodyHeight = 200,
    List<BaseDialogListItem>? listItems,
    List<String>? selectOptions,
    int selectedIndex = 0,
    String? primaryLabel,
    VoidCallback? onPrimary,
    void Function(int index)? onPrimaryWithIndex,
    String? secondaryLabel,
    VoidCallback? onSecondary,
    bool primaryFirst = false,
    bool barrierDismissible = true,
    Color? barrierColor,
    bool popOnAction = true,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierDismissible ? context.l10n.dismiss : null,
      barrierColor: DialogKitLayout.modalBarrierColor(context, barrierColor),
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (_, animation, _, child) {
        final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            child: child,
          ),
        );
      },
      pageBuilder: (dialogContext, _, _) {
        final scheme = Theme.of(dialogContext).colorScheme;
        final surface = scheme.surface;
        return PopScope(
          canPop: barrierDismissible,
          child: SizedBox.expand(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _maxWidth),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(DialogKitLayout.cornerRadius),
                    boxShadow: DialogKitLayout.dialogCardShadows(scheme),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(DialogKitLayout.cornerRadius),
                    child: Material(
                      color: surface,
                      child: Padding(
                        padding: const EdgeInsets.all(DialogKitLayout.padding),
                        child: BaseDialogKitPanel<T>(
                          hostContext: dialogContext,
                          expandActions: false,
                          type: type,
                          title: title,
                          description: description,
                          showClose: showClose,
                          bodyText: bodyText,
                          body: body,
                          checkboxLabel: checkboxLabel,
                          checkboxItems: checkboxItems,
                          checkboxValue: checkboxValue,
                          onCheckboxChanged: onCheckboxChanged,
                          onCheckboxesChanged: onCheckboxesChanged,
                          maxBodyHeight: maxBodyHeight,
                          listItems: listItems,
                          selectOptions: selectOptions,
                          selectedIndex: selectedIndex,
                          primaryLabel: primaryLabel,
                          onPrimary: onPrimary,
                          onPrimaryWithIndex: onPrimaryWithIndex,
                          secondaryLabel: secondaryLabel,
                          onSecondary: onSecondary,
                          primaryFirst: primaryFirst,
                          popOnAction: popOnAction,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FullscreenActionRow extends StatelessWidget {
  const _FullscreenActionRow({
    required this.dialogContext,
    this.primaryLabel,
    this.primaryOnPressed,
    this.secondaryLabel,
    this.secondaryOnPressed,
    required this.primaryFirst,
  });

  final BuildContext dialogContext;
  final String? primaryLabel;
  final VoidCallback? primaryOnPressed;
  final String? secondaryLabel;
  final VoidCallback? secondaryOnPressed;
  final bool primaryFirst;

  void _popAfter(VoidCallback? fn) {
    fn?.call();
    if (dialogContext.mounted) Navigator.of(dialogContext).pop();
  }

  @override
  Widget build(BuildContext context) {
    final secondary = secondaryLabel != null
        ? OutlinedButton(
            onPressed: () => _popAfter(secondaryOnPressed),
            child: Text(secondaryLabel!),
          )
        : null;
    final primary = primaryLabel != null
        ? FilledButton(
            onPressed: () => _popAfter(primaryOnPressed),
            child: Text(primaryLabel!),
          )
        : null;

    if (secondary != null && primary != null) {
      return Row(
        children: [
          if (primaryFirst) ...[
            Expanded(child: primary),
            const SizedBox(width: 8),
            Expanded(child: secondary),
          ] else ...[
            Expanded(child: secondary),
            const SizedBox(width: 8),
            Expanded(child: primary),
          ],
        ],
      );
    }
    if (primary != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [primary],
      );
    }
    if (secondary != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [secondary],
      );
    }
    return const SizedBox.shrink();
  }
}
