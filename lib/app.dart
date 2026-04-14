import 'package:app_log/app_log.dart';
import 'package:app_log/app_log_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_app/app_config.dart';
import 'package:mobile_app/src/config/di/injection.dart';
import 'package:mobile_app/src/config/router/app_router.dart';
import 'package:mobile_app/src/config/theme/app_theme.dart';
import 'package:mobile_app/src/core/language/generated/app_localizations.dart';
import 'package:mobile_app/src/features/user_config/presentation/bloc/locale_bloc/locale_bloc.dart';
import 'package:mobile_app/src/features/user_config/presentation/theme/app_theme_scope.dart';

import 'src/core/utils/constants/locale_constants.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(final BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) {
          final deviceLanguageCode =
              WidgetsBinding.instance.platformDispatcher.locale.languageCode;
          return sl<LocaleBloc>()
            ..add(LocaleEvent.started(deviceLanguageCode: deviceLanguageCode));
        },
      ),
    ],
    child: AppThemeScope(
      builder: (context, themeMode, child) {
        final appRouter = sl<AppRouter>();
        return BlocBuilder<LocaleBloc, LocaleState>(
          builder: (context, localeState) => MaterialApp.router(
            builder: (context, child) {
              if (AppConfig.instance.environment != 'production') {
                return Stack(
                  children: [
                    ?child,
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: LogViewerButton(
                        navigatorKey: appRouter.navigatorKey,
                      ),
                    ),
                  ],
                );
              }
              return child ?? const SizedBox.shrink();
            },
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter.config(
              navigatorObservers: () => [
                // AnalyticsPageObserver(),
                AutoRouteLogObserver(),
              ],
            ),
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: localeState.languageCode != null
                ? Locale(localeState.languageCode!)
                : null,
            supportedLocales: LocaleConstants.supportedLocales,
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              final languageCode = localeState.languageCode;
              if (languageCode != null) return Locale(languageCode);

              for (final locale in supportedLocales) {
                if (locale.languageCode == deviceLocale?.languageCode) {
                  return locale;
                }
              }
              return LocaleConstants.defaultLocale;
            },
          ),
        );
      },
    ),
  );
}
