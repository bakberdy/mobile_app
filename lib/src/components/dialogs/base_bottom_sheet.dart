import 'package:flutter/material.dart';
import 'package:mobile_app/src/components/dialogs/base_dialog_kit_panel.dart';
import 'package:mobile_app/src/components/dialogs/dialog_kit_layout.dart';
import 'package:mobile_app/src/components/dialogs/dialog_kit_models.dart';

/// Optional alias: `BaseBottomSheet.show(context, type: BaseBottomSheetType.basic, …)`.
typedef BaseBottomSheetType = BaseDialogType;

/// Same content modes as [BaseDialog], presented as a modal bottom sheet (Figma bottom row).
///
/// Use [show] with [BaseBottomSheetType] / [BaseDialogType] or shortcuts like [showBasic].
class BaseBottomSheet {
  BaseBottomSheet._();

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
    bool isDismissible = true,
    bool enableDrag = true,
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
      isDismissible: isDismissible,
      enableDrag: enableDrag,
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
    bool isDismissible = true,
    bool enableDrag = true,
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
      isDismissible: isDismissible,
      enableDrag: enableDrag,
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
    bool isDismissible = true,
    bool enableDrag = true,
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
      isDismissible: isDismissible,
      enableDrag: enableDrag,
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
    bool isDismissible = true,
    bool enableDrag = true,
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
      isDismissible: isDismissible,
      enableDrag: enableDrag,
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
    bool isDismissible = true,
    bool enableDrag = true,
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
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      barrierColor: barrierColor,
      popOnAction: popOnAction,
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
    bool isDismissible = true,
    bool enableDrag = true,
    Color? barrierColor,
    bool popOnAction = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Theme.of(
        context,
      ).colorScheme.surface.withValues(alpha: 0),
      barrierColor: DialogKitLayout.modalBarrierColor(context, barrierColor),
      builder: (sheetContext) {
        final bottomInset = MediaQuery.viewInsetsOf(sheetContext).bottom;
        final size = MediaQuery.sizeOf(sheetContext);
        final maxH = size.height * 0.92;
        return Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              color: Theme.of(sheetContext).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(DialogKitLayout.cornerRadius),
              ),
              clipBehavior: Clip.antiAlias,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: size.width,
                  maxHeight: maxH,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(DialogKitLayout.padding),
                    child: BaseDialogKitPanel<T>(
                      hostContext: sheetContext,
                      expandActions: true,
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
        );
      },
    );
  }
}
