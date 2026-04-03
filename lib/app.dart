import 'package:app_log/app_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/src/config/router/app_router.dart';
import 'package:mobile_app/src/config/theme/app_theme.dart';
import 'package:mobile_app/src/config/di/injection.dart';
import 'package:mobile_app/src/core/language/generated/app_localizations.dart';
import 'package:mobile_app/src/features/user_config/presentation/bloc/locale_bloc/locale_bloc.dart';
import 'package:mobile_app/src/features/user_config/presentation/theme/app_theme_scope.dart';
import 'src/core/utils/constants/locale_constants.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final deviceLanguageCode =
                WidgetsBinding.instance.platformDispatcher.locale.languageCode;
            return sl<LocaleBloc>()..add(
              LocaleEvent.started(deviceLanguageCode: deviceLanguageCode),
            );
          },
        ),
      ],
      child: AppThemeScope(
        builder: (context, themeMode, child) {
          return BlocBuilder<LocaleBloc, LocaleState>(
            builder: (context, localeState) {
              return MaterialApp.router(
                builder: (context, child) {
                  if ()
                },
                debugShowCheckedModeBanner: false,
                routerConfig: sl<AppRouter>().config(
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
              );
            },
          );
        },
      ),
    );
  }
}
