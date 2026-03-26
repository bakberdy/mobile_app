import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/src/config/di/injection.dart';
import 'package:travel_app/src/features/user_config/domain/entity/app_theme_mode.dart';
import 'package:travel_app/src/features/user_config/presentation/bloc/theme_bloc/theme_bloc.dart';

typedef AppThemeScopeBuilder =
    Widget Function(BuildContext context, ThemeMode themeMode, Widget? child);

class AppThemeScope extends StatelessWidget {
  final AppThemeScopeBuilder builder;
  final Widget? child;

  const AppThemeScope({required this.builder, this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ThemeBloc>(),
      child: _AppThemeScopeBody(builder: builder, child: child),
    );
  }
}

class _AppThemeScopeBody extends StatefulWidget {
  final AppThemeScopeBuilder builder;
  final Widget? child;

  const _AppThemeScopeBody({required this.builder, this.child});

  @override
  State<_AppThemeScopeBody> createState() => _AppThemeScopeBodyState();
}

class _AppThemeScopeBodyState extends State<_AppThemeScopeBody>
    with WidgetsBindingObserver {
  late final ThemeBloc _themeBloc;

  AppThemeMode _readSystemThemeMode() {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark
        ? AppThemeMode.dark
        : AppThemeMode.light;
  }

  void _syncSystemThemeMode() {
    _themeBloc.applySystemThemeMode(_readSystemThemeMode());
  }

  @override
  void initState() {
    super.initState();
    _themeBloc = context.read<ThemeBloc>();
    WidgetsBinding.instance.addObserver(this);
    _themeBloc.start(systemThemeMode: _readSystemThemeMode());
  }

  @override
  void didChangePlatformBrightness() {
    _syncSystemThemeMode();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _syncSystemThemeMode();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return widget.builder(context, _toThemeMode(themeState.appliedThemeMode ?? AppThemeMode.system), widget.child);
      },
    );
  }

  ThemeMode _toThemeMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.system:
        return ThemeMode.system;
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
    }
  }
}
