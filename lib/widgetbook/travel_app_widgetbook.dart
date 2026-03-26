import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travel_app/src/components/buttons/base_elevated_button.dart';
import 'package:travel_app/src/components/buttons/base_filled_button.dart';
import 'package:travel_app/src/components/buttons/base_icon_button.dart';
import 'package:travel_app/src/components/buttons/base_outlined_button.dart';
import 'package:travel_app/src/components/buttons/base_text_button.dart';
import 'package:travel_app/src/components/dialogs/base_bottom_sheet.dart';
import 'package:travel_app/src/components/dialogs/base_dialog.dart';
import 'package:travel_app/src/components/dialogs/base_snackbar.dart';
import 'package:travel_app/src/config/theme/app_theme.dart';
import 'package:travel_app/src/core/language/generated/app_localizations.dart';
import 'package:travel_app/src/core/utils/constants/locale_constants.dart';
import 'package:widgetbook/widgetbook.dart';

/// Captured once so [MaterialThemeAddon]'s `initialTheme` is the same instance
/// as an element of `themes` (`ThemeData` from getters is not `==` across calls).
final _widgetbookMaterialThemes = [
  WidgetbookTheme(name: 'Light', data: AppTheme.lightTheme),
  WidgetbookTheme(name: 'Dark', data: AppTheme.darkTheme),
];

/// Widgetbook catalog for Travel App design-system widgets.
class TravelAppWidgetbook extends StatelessWidget {
  const TravelAppWidgetbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      lightTheme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      appBuilder: _materialAppWithL10n,
      addons: [
        AlignmentAddon(),
        MaterialThemeAddon(
          themes: _widgetbookMaterialThemes,
          initialTheme: _widgetbookMaterialThemes.first,
        ),
      ],
      directories: [_rootCategory],
    );
  }
}

Widget _materialAppWithL10n(BuildContext context, Widget child) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    locale: LocaleConstants.defaultLocale,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: LocaleConstants.supportedLocales,
    home: Material(child: child),
  );
}

final _rootCategory = WidgetbookCategory(
  name: 'travel_app',
  isInitiallyExpanded: true,
  children: [
    WidgetbookFolder(
      name: 'Buttons',
      children: [
        WidgetbookComponent(
          name: 'BaseFilledButton',
          useCases: [
            WidgetbookUseCase(
              name: 'Primary',
              builder: (context) => BaseFilledButton.primary(
                label: 'Primary',
                onPressed: () {},
              ),
            ),
            WidgetbookUseCase(
              name: 'Primary + icon',
              builder: (context) => BaseFilledButton.primary(
                label: 'With icon',
                icon: Icons.send_rounded,
                onPressed: () {},
              ),
            ),
            WidgetbookUseCase(
              name: 'Secondary',
              builder: (context) => BaseFilledButton.secondary(
                label: 'Secondary',
                onPressed: () {},
              ),
            ),
            WidgetbookUseCase(
              name: 'Loading',
              builder: (context) => BaseFilledButton.primary(
                label: 'Loading',
                onPressed: () {},
                loading: true,
              ),
            ),
            WidgetbookUseCase(
              name: 'Disabled',
              builder: (context) => BaseFilledButton.primary(
                label: 'Disabled',
                onPressed: () {},
                disabled: true,
              ),
            ),
          ],
        ),
        WidgetbookComponent(
          name: 'BaseOutlinedButton',
          useCases: [
            WidgetbookUseCase(
              name: 'Primary',
              builder: (context) => BaseOutlinedButton.primary(
                label: 'Outlined primary',
                onPressed: () {},
              ),
            ),
            WidgetbookUseCase(
              name: 'Secondary',
              builder: (context) => BaseOutlinedButton.secondary(
                label: 'Outlined secondary',
                onPressed: () {},
              ),
            ),
          ],
        ),
        WidgetbookComponent(
          name: 'BaseTextButton',
          useCases: [
            WidgetbookUseCase(
              name: 'Primary',
              builder: (context) => BaseTextButton.primary(
                label: 'Text primary',
                onPressed: () {},
              ),
            ),
            WidgetbookUseCase(
              name: 'Secondary',
              builder: (context) => BaseTextButton.secondary(
                label: 'Text secondary',
                onPressed: () {},
              ),
            ),
          ],
        ),
        WidgetbookComponent(
          name: 'BaseElevatedButton',
          useCases: [
            WidgetbookUseCase(
              name: 'Primary',
              builder: (context) => BaseElevatedButton.primary(
                label: 'Elevated primary',
                onPressed: () {},
              ),
            ),
            WidgetbookUseCase(
              name: 'Secondary',
              builder: (context) => BaseElevatedButton.secondary(
                label: 'Elevated secondary',
                onPressed: () {},
              ),
            ),
          ],
        ),
        WidgetbookComponent(
          name: 'BaseIconButton',
          useCases: [
            WidgetbookUseCase(
              name: 'Standard',
              builder: (context) => BaseIconButton.standard(
                icon: const Icon(Icons.favorite_border_rounded),
                onPressed: () {},
                tooltip: 'Favorite',
              ),
            ),
            WidgetbookUseCase(
              name: 'Primary',
              builder: (context) => BaseIconButton.primary(
                icon: const Icon(Icons.favorite_rounded),
                onPressed: () {},
                tooltip: 'Favorite',
              ),
            ),
            WidgetbookUseCase(
              name: 'Secondary',
              builder: (context) => BaseIconButton.secondary(
                icon: const Icon(Icons.share_rounded),
                onPressed: () {},
                tooltip: 'Share',
              ),
            ),
          ],
        ),
      ],
    ),
    WidgetbookFolder(
      name: 'Dialogs',
      children: [
        WidgetbookComponent(
          name: 'BaseDialog',
          useCases: [
            WidgetbookUseCase(
              name: 'Basic',
              builder: (context) => _DialogLaunchPad(
                label: 'Open basic dialog',
                onOpen: () => BaseDialog.showBasic(
                  context,
                  title: 'Dialog title',
                  bodyText: 'Short body copy for the dialog.',
                  primaryLabel: 'OK',
                  onPrimary: () {},
                ),
              ),
            ),
            WidgetbookUseCase(
              name: 'Checkbox',
              builder: (context) => _DialogLaunchPad(
                label: 'Open checkbox dialog',
                onOpen: () => BaseDialog.showCheckbox(
                  context,
                  title: 'Terms',
                  checkboxLabel: 'I agree',
                  primaryLabel: 'Continue',
                  onPrimary: () {},
                ),
              ),
            ),
            WidgetbookUseCase(
              name: 'Multiple checkboxes',
              builder: (context) => _DialogLaunchPad(
                label: 'Open multi-checkbox dialog',
                onOpen: () => BaseDialog.showCheckbox(
                  context,
                  title: 'Pick options',
                  checkboxItems: const [
                    BaseDialogCheckboxItem(label: 'Option A'),
                    BaseDialogCheckboxItem(label: 'Option B', value: true),
                    BaseDialogCheckboxItem(label: 'Option C'),
                  ],
                  primaryLabel: 'Save',
                  onPrimary: () {},
                ),
              ),
            ),
            WidgetbookUseCase(
              name: 'List',
              builder: (context) => _DialogLaunchPad(
                label: 'Open list dialog',
                onOpen: () => BaseDialog.showList(
                  context,
                  title: 'Choose item',
                  items: const [
                    BaseDialogListItem(title: 'Alpha', subtitle: 'First'),
                    BaseDialogListItem(title: 'Beta', subtitle: 'Second'),
                  ],
                  primaryLabel: 'Done',
                  onPrimary: () {},
                ),
              ),
            ),
            WidgetbookUseCase(
              name: 'Select',
              builder: (context) => _DialogLaunchPad(
                label: 'Open select dialog',
                onOpen: () => BaseDialog.showSelect(
                  context,
                  title: 'Choose one',
                  options: const ['One', 'Two', 'Three'],
                  selectedIndex: 1,
                  primaryLabel: 'Apply',
                  onPrimary: (_) {},
                ),
              ),
            ),
            WidgetbookUseCase(
              name: 'Scrollable',
              builder: (context) => _DialogLaunchPad(
                label: 'Open scrollable dialog',
                onOpen: () => BaseDialog.showScrollable(
                  context,
                  title: 'Scroll me',
                  bodyText: List.filled(20, 'Line of sample text.').join(' '),
                  primaryLabel: 'Close',
                  onPrimary: () {},
                ),
              ),
            ),
            WidgetbookUseCase(
              name: 'Fullscreen',
              builder: (context) => _DialogLaunchPad(
                label: 'Open fullscreen dialog',
                onOpen: () => BaseDialog.showFullscreen(
                  context,
                  title: 'Fullscreen',
                  bodyText: 'Fullscreen body content.',
                  primaryLabel: 'Done',
                  onPrimary: () {},
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    WidgetbookFolder(
      name: 'Bottom sheets',
      children: [
        WidgetbookComponent(
          name: 'BaseBottomSheet',
          useCases: [
            WidgetbookUseCase(
              name: 'Basic sheet',
              builder: (context) => _DialogLaunchPad(
                label: 'Open bottom sheet',
                onOpen: () => BaseBottomSheet.showBasic(
                  context,
                  title: 'Sheet title',
                  bodyText: 'Sheet body text.',
                  primaryLabel: 'OK',
                  onPrimary: () {},
                ),
              ),
            ),
            WidgetbookUseCase(
              name: 'Scrollable sheet',
              builder: (context) => _DialogLaunchPad(
                label: 'Open scrollable sheet',
                onOpen: () => BaseBottomSheet.showScrollable(
                  context,
                  title: 'Scrollable',
                  bodyText: List.filled(15, 'Sample row text. ').join(),
                  primaryLabel: 'Done',
                  onPrimary: () {},
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    WidgetbookFolder(
      name: 'Feedback',
      children: [
        WidgetbookComponent(
          name: 'BaseSnackbar',
          useCases: [
            WidgetbookUseCase(
              name: 'Info',
              builder: (context) => _DialogLaunchPad(
                label: 'Show info snackbar',
                onOpen: () => BaseSnackbar.info(
                  context,
                  message: 'Informational message.',
                ),
              ),
            ),
            WidgetbookUseCase(
              name: 'Success',
              builder: (context) => _DialogLaunchPad(
                label: 'Show success snackbar',
                onOpen: () => BaseSnackbar.success(
                  context,
                  message: 'Saved successfully.',
                ),
              ),
            ),
            WidgetbookUseCase(
              name: 'Warning',
              builder: (context) => _DialogLaunchPad(
                label: 'Show warning snackbar',
                onOpen: () => BaseSnackbar.warning(
                  context,
                  message: 'Please review your input.',
                ),
              ),
            ),
            WidgetbookUseCase(
              name: 'Error',
              builder: (context) => _DialogLaunchPad(
                label: 'Show error snackbar',
                onOpen: () => BaseSnackbar.error(
                  context,
                  message: 'Something went wrong.',
                ),
              ),
            ),
            WidgetbookUseCase(
              name: 'With action',
              builder: (context) => _DialogLaunchPad(
                label: 'Show snackbar + action',
                onOpen: () => BaseSnackbar.show(
                  context,
                  message: 'Item removed.',
                  type: BaseSnackbarType.info,
                  actionLabel: 'Undo',
                  onAction: () {},
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

/// Scaffold so [ScaffoldMessenger] exists for dialogs and snackbars.
class _DialogLaunchPad extends StatelessWidget {
  const _DialogLaunchPad({
    required this.label,
    required this.onOpen,
  });

  final String label;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BaseFilledButton.primary(
          label: label,
          onPressed: onOpen,
        ),
      ),
    );
  }
}
