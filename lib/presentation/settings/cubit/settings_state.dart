part of 'settings_cubit.dart';

@immutable
class SettingsState {
  final bool isNotificationsPermitted;
  final bool isDarkTheme;
  final Locale locale;
  final String? message;

  const SettingsState({
    required this.isNotificationsPermitted,
    required this.locale,
    required this.message,
    required this.isDarkTheme,
  });

  SettingsState copyWith({
    bool? isNotificationsPermitted,
    bool? isDarkTheme,
    Locale? locale,
    String? message,
  }) {
    return SettingsState(
      isNotificationsPermitted:
          isNotificationsPermitted ?? this.isNotificationsPermitted,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      locale: locale ?? this.locale,
      message: message ?? this.message,
    );
  }
}
