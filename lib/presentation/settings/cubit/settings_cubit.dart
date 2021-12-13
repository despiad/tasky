import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasky/infrastructure/repositories/notification_repository.dart';
import 'package:tasky/localization/localization_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final NotificationRepository _notificationRepository;

  SettingsCubit(this._notificationRepository)
      : super(const SettingsState(
          message: null,
          isNotificationsPermitted: false,
          locale: Locale('en'),
          isDarkTheme: false,
        ));

  Future<void> changeLocale(Locale locale) async {
    try {
      emit(state.copyWith(locale: locale));
    } catch (e) {
      emit(state.copyWith(
        message: LocaleKeys.settings_screen_locale_change_error.tr(),
      ));
    }
  }

  Future<void> changePermission() async {
    try {
      await _notificationRepository.changePermission();
    } catch (e) {
      emit(state.copyWith(
        message: LocaleKeys.settings_screen_notification_change_error.tr(),
        isNotificationsPermitted: false,
      ));
    }
  }

  Future<void> changeTheme(bool isDarkTheme) async {
    try {
      emit(state.copyWith(isDarkTheme: isDarkTheme));
    } catch (e) {
      emit(state.copyWith(
        message: LocaleKeys.settings_screen_notification_change_error.tr(),
      ));
    }
  }

  Future<void> isNotificationsGranted() async {
    final isGranted = await _notificationRepository.isGranted();
    _emitDependingOn(isGranted);
  }

  void _emitDependingOn(bool isGranted) {
    if (isGranted) {
      emit(state.copyWith(
        message: LocaleKeys.settings_screen_notification_permitted.tr(),
        isNotificationsPermitted: true,
      ));
    } else {
      emit(state.copyWith(
        message: LocaleKeys.settings_screen_notification_not_permitted.tr(),
        isNotificationsPermitted: false,
      ));
    }
  }
}
