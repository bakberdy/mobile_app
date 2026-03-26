import 'package:flutter/material.dart';

/// Content variants from the [Dialog UI Kit](https://www.figma.com/design/iESOJrBixUXf4DC4hyljgy/Dialog-UI-Kit--Community-?node-id=4-94).
enum BaseDialogType {
  basic,
  checkbox,
  scrollable,
  list,
  select,
}

/// One row in [BaseDialogType.checkbox] when using multiple checkboxes.
class BaseDialogCheckboxItem {
  const BaseDialogCheckboxItem({required this.label, this.value = false});

  final String label;
  final bool value;
}

/// Row used with [BaseDialogType.list] (dialogs and bottom sheets).
class BaseDialogListItem {
  const BaseDialogListItem({
    this.leading,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  final Widget? leading;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
}
