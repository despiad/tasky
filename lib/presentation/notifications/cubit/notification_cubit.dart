import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:tasky/domain/models/task.dart';
import 'package:tasky/infrastructure/repositories/notification_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository _notificationRepository;

  NotificationCubit(this._notificationRepository)
      : super(const NotificationState(null, false));

  Future<void> cancelNotification(int id) async {
    try {
      await _notificationRepository.cancelNotification(id);
      emit(state.copyWith(message: 'Notification successfully canceled'));
    } catch (e) {
      emit(state.copyWith(
          message: 'An error occurred while cancelling notification'));
    }
  }

  Future<void> createNotificationFromTask(Task task) async {
    try {
      await _notificationRepository.createNotificationFromTask(task);
      emit(state.copyWith(message: 'Notification successfully created'));
    } catch (e) {
      emit(state.copyWith(
          message: 'An error occurred while creating notification'));
    }
  }

  Future<void> changePermission() async {
    try {
       await _notificationRepository.changePermission();
    } catch (e) {
      emit(const NotificationState(
          'An error occurred while changing permission', false));
    }
  }

  Future<void> isGranted() async {
    final isGranted = await _notificationRepository.isGranted();
    _emitDependingOn(isGranted);
  }

  void _emitDependingOn(bool isGranted) {
    if (isGranted) {
      emit(const NotificationState('Notifications are permitted', true));
    } else {
      emit(const NotificationState('Notifications are not permitted', false));
    }
  }
}
