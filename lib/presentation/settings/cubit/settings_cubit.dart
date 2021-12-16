import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasky/domain/models/settings.dart';
import 'package:tasky/infrastructure/repositories/settings_repository.dart';
import 'package:tasky/localization/localization_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _settingsRepository;

  StreamSubscription<Settings>? _settingsSubscr;

  SettingsCubit(this._settingsRepository)
      : super(const SettingsState(
          message: null,
          isNotificationsPermitted: false,
          locale: Locale('en'),
          isDarkTheme: false,
        ));

  void watchSettings() {
    _settingsSubscr = _settingsRepository.watchSettings().listen((settings) {
      emit(SettingsState(
        isNotificationsPermitted: settings.isNotificationPermitted,
        locale: Locale(settings.locale),
        message: null,
        isDarkTheme: settings.isDarkTheme,
      ));
    });
  }

  Future<void> changeLocale(Locale locale) async {
    try {
      emit(state.copyWith(locale: locale));
      _settingsRepository.updateSettings(Settings(
          locale: state.locale.languageCode,
          isNotificationPermitted: state.isNotificationsPermitted,
          isDarkTheme: state.isDarkTheme));
    } catch (e) {
      emit(state.copyWith(
        message: LocaleKeys.settings_screen_locale_change_error.tr(),
      ));
    }
  }

  Future<void> changePermission() async {
    try {
      await _settingsRepository.changePermission();
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
      _settingsRepository.updateSettings(Settings(
          locale: state.locale.languageCode,
          isNotificationPermitted: state.isNotificationsPermitted,
          isDarkTheme: state.isDarkTheme));
    } catch (e) {
      emit(state.copyWith(
        message: LocaleKeys.settings_screen_notification_change_error.tr(),
      ));
    }
  }

  Future<void> isNotificationsGranted() async {
    final isGranted = await _settingsRepository.isGranted();
    _emitDependingOn(isGranted);
    _settingsRepository.updateSettings(Settings(
        locale: state.locale.languageCode,
        isNotificationPermitted: state.isNotificationsPermitted,
        isDarkTheme: state.isDarkTheme));
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

  @override
  Future<void> close() {
    _settingsSubscr?.cancel();
    return super.close();
  }
}
