import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/src/components/dialogs/base_snackbar.dart';
import 'package:travel_app/src/core/utils/constants/locale_constants.dart';
import 'package:travel_app/src/core/utils/extensions/context_x.dart';
import 'package:travel_app/src/features/user_config/domain/entity/app_theme_mode.dart';
import 'package:travel_app/src/features/user_config/presentation/bloc/locale_bloc/locale_bloc.dart';
import 'package:travel_app/src/features/user_config/presentation/bloc/theme_bloc/theme_bloc.dart';

@RoutePage()
class UserConfigExamplePage extends StatefulWidget {
  const UserConfigExamplePage({super.key});

  @override
  State<UserConfigExamplePage> createState() => _UserConfigExampleScreenState();
}

class _UserConfigExampleScreenState extends State<UserConfigExamplePage> {
  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    final localeState = context.watch<LocaleBloc>().state;
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.themeMode)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            DropdownButton<AppThemeMode>(
              borderRadius: BorderRadius.circular(16),
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
            SizedBox(height: 16),
            DropdownButton<String>(
              borderRadius: BorderRadius.circular(16),
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

            const SizedBox(height: 24),
            Text('Snackbar', style: context.textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: () => BaseSnackbar.success(
                    context,
                    message: 'Route saved successfully',
                  ),
                  child: const Text('Success'),
                ),
                FilledButton(
                  onPressed: () => BaseSnackbar.error(
                    context,
                    message: 'Failed to load route data',
                  ),
                  child: const Text('Error'),
                ),
                FilledButton(
                  onPressed: () => BaseSnackbar.warning(
                    context,
                    message: 'GPS signal is weak',
                  ),
                  child: const Text('Warning'),
                ),
                FilledButton(
                  onPressed: () => BaseSnackbar.info(
                    context,
                    message: 'Pull down to refresh routes',
                  ),
                  child: const Text('Info'),
                ),
                FilledButton(
                  onPressed: () => BaseSnackbar.error(
                    context,
                    message: 'Route deleted',
                    actionLabel: 'Undo',
                    onAction: () => BaseSnackbar.success(
                      context,
                      message: 'Route restored',
                    ),
                  ),
                  child: const Text('With action'),
                ),
                OutlinedButton(
                  onPressed: () => BaseSnackbar.hide(context),
                  child: const Text('Hide'),
                ),
              ],
            ),
             const SizedBox(height: 24),
            Text('Banner', style: context.textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              children: [
                FilledButton(
                  onPressed: () => ScaffoldMessenger.of(context).showMaterialBanner(
                    MaterialBanner(
                      content: Text('Custom'),
                      actions: [
                        TextButton(onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                        }, child: Text('Hide')),
                      ],
                    ),
                  ),
                  child: const Text('Banner'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
