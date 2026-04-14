import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/app_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
  final config = AppConfig.instance;
  PackageInfo? _packageInfo;

  @override
  void initState() {
    super.initState();
    unawaited(_loadPackageInfo());
  }

  Future<void> _loadPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    if (!mounted) {
      return;
    }
    setState(() => _packageInfo = info);
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    final localeState = context.watch<LocaleBloc>().state;
    final packageInfo = _packageInfo;
    final versionLabel = packageInfo == null
        ? ''
        : context.l10n.appVersionWithBuild(
            packageInfo.version,
            packageInfo.buildNumber,
          );
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
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(AppRadii.lg),
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.shadow.withValues(alpha: 0.12),
                    blurRadius: 32,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(versionLabel),
                  Text('API URL: ${config.baseUrl}'),
                  Text('Environment: ${config.environment}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
