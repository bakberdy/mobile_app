import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/src/components/buttons/base_filled_button.dart';
import 'package:mobile_app/src/components/buttons/base_outlined_button.dart';
import 'package:mobile_app/src/components/dialogs/base_snackbar.dart';
import 'package:mobile_app/src/config/theme/app_radii.dart';
import 'package:mobile_app/src/config/theme/app_spacing.dart';
import 'package:mobile_app/src/core/utils/constants/locale_constants.dart';
import 'package:mobile_app/src/core/utils/extensions/context_x.dart';
import 'package:mobile_app/src/features/user_config/domain/entity/app_theme_mode.dart';
import 'package:mobile_app/src/features/user_config/presentation/bloc/locale_bloc/locale_bloc.dart';
import 'package:mobile_app/src/features/user_config/presentation/bloc/theme_bloc/theme_bloc.dart';

@RoutePage()
class UserConfigExampleScreen extends StatefulWidget {
  const UserConfigExampleScreen({super.key});

  @override
  State<UserConfigExampleScreen> createState() =>
      _UserConfigExampleScreenState();
}

class _UserConfigExampleScreenState extends State<UserConfigExampleScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    final localeState = context.watch<LocaleBloc>().state;
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.themeMode)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<AppThemeMode>(
              borderRadius: BorderRadius.circular(AppRadii.lg),
              underline: const SizedBox(),
              value: themeState.themeMode,
              hint: Text(context.l10n.notSelected),
              items: [
                DropdownMenuItem<AppThemeMode>(
                  value: AppThemeMode.light,
                  child: Text(context.l10n.light),
                ),
                DropdownMenuItem<AppThemeMode>(
                  value: AppThemeMode.dark,
                  child: Text(context.l10n.dark),
                ),
                DropdownMenuItem<AppThemeMode>(
                  value: AppThemeMode.system,
                  child: Text(context.l10n.system),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  context.read<ThemeBloc>().setThemeMode(value);
                }
              },
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButton<String>(
              borderRadius: BorderRadius.circular(AppRadii.lg),
              underline: const SizedBox(),
              value: localeState.languageCode,
              hint: Text(context.l10n.notSelected),
              items: [
                DropdownMenuItem<String>(
                  value: LocaleConstants.kazakh.languageCode,
                  child: Text(context.l10n.kazakh),
                ),
                DropdownMenuItem<String>(
                  value: LocaleConstants.russian.languageCode,
                  child: Text(context.l10n.russian),
                ),
                DropdownMenuItem<String>(
                  value: LocaleConstants.english.languageCode,
                  child: Text(context.l10n.english),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  context.read<LocaleBloc>().setLocale(value);
                }
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Snackbar', style: context.textTheme.titleMedium),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                BaseFilledButton.primary(
                  onPressed: () => BaseSnackbar.success(
                    context,
                    message: 'Route saved successfully',
                  ),
                  label: 'Success',
                  expand: false,
                ),
                BaseFilledButton.primary(
                  onPressed: () => BaseSnackbar.error(
                    context,
                    message: 'Failed to load route data',
                  ),
                  label: 'Error',
                  expand: false,
                ),
                BaseFilledButton.primary(
                  onPressed: () => BaseSnackbar.warning(
                    context,
                    message: 'GPS signal is weak',
                  ),
                  label: 'Warning',
                  expand: false,
                ),
                BaseFilledButton.primary(
                  onPressed: () => BaseSnackbar.info(
                    context,
                    message: 'Pull down to refresh routes',
                  ),
                  label: 'Info',
                  expand: false,
                ),
                BaseFilledButton.primary(
                  onPressed: () => BaseSnackbar.error(
                    context,
                    message: 'Route deleted',
                    actionLabel: 'Undo',
                    onAction: () => BaseSnackbar.success(
                      context,
                      message: 'Route restored',
                    ),
                  ),
                  label: 'With action',
                  expand: false,
                ),
                BaseOutlinedButton.primary(
                  onPressed: () => BaseSnackbar.hide(context),
                  label: 'Hide',
                  expand: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
