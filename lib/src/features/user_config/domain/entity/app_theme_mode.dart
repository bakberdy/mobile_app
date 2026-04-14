enum AppThemeMode {
  system,
  light,
  dark;

  static AppThemeMode? fromString(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    for (final mode in AppThemeMode.values) {
      if (mode.name == value.trim()) {
        return mode;
      }
    }
    return null;
  }
}
