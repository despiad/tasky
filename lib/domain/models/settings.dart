class Settings {
  final String locale;
  final bool isNotificationPermitted;
  final bool isDarkTheme;

  Settings({
    required this.locale,
    required this.isNotificationPermitted,
    required this.isDarkTheme,
  });

  Settings copyWith({
    String? locale,
    bool? isNotificationPermitted,
    bool? isDarkTheme,
  }) {
    return Settings(
      locale: locale ?? this.locale,
      isNotificationPermitted:
          isNotificationPermitted ?? this.isNotificationPermitted,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
    );
  }
}
