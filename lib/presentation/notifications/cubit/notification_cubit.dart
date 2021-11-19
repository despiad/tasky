import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:tasky/domain/models/task.dart';
import 'package:tasky/infrastructure/repositories/notification_repository.dart';
import 'package:tasky/localization/localization_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository _notificationRepository;

  NotificationCubit(this._notificationRepository)
      : super(const NotificationState(null));

  Future<void> cancelNotification(int id) async {
    try {
      await _notificationRepository.cancelNotification(id);
      emit(state.copyWith(
          message: LocaleKeys.create_screen_notification_cancelled.tr()));
    } catch (e) {
      emit(state.copyWith(
          message: LocaleKeys.create_screen_notification_cancelled_error));
    }
  }

  Future<void> createNotificationFromTask(Task task) async {
    try {
      await _notificationRepository.createNotificationFromTask(task);
      emit(state.copyWith(
          message: LocaleKeys.create_screen_notification_created.tr()));
    } catch (e) {
      emit(state.copyWith(
          message: LocaleKeys.create_screen_notification_created_error.tr()));
    }
  }
}
