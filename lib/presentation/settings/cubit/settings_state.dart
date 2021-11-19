part of 'settings_cubit.dart';

@immutable
class SettingsState {
  final bool isNotificationsPermitted;
  final Locale locale;
  final String? message;

  const SettingsState({
    required this.isNotificationsPermitted,
    required this.locale,
    required this.message,
  });

  SettingsState copyWith({
    String? message,
    bool? isNotificationsPermitted,
    Locale? locale,
  }) {
    return SettingsState(
      isNotificationsPermitted:
          isNotificationsPermitted ?? this.isNotificationsPermitted,
      locale: locale ?? this.locale,
      message: message,
    );
  }
}
