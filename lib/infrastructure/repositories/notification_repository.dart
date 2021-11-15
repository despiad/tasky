import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tasky/domain/models/task.dart';
import 'package:tasky/utils/constants.dart';
import 'package:timezone/timezone.dart' as tz;

abstract class NotificationRepository {
  Future<bool?>? requestPermissions();

  Future<void> createNotificationFromTask(Task task);

  Future<void> cancelNotification(int id);

  Future<bool> isGranted();

  Future<bool> changePermission();
}

class NotificationRepositoryImpl implements NotificationRepository {
  final FlutterLocalNotificationsPlugin _notificationsPlugin;

  NotificationRepositoryImpl(this._notificationsPlugin);

  @override
  Future<void> cancelNotification(int id) {
    return _notificationsPlugin.cancel(id);
  }

  @override
  Future<void> createNotificationFromTask(Task task) {
    return _notificationsPlugin.zonedSchedule(
      task.id,
      'Task ${task.id} is about to start',
      task.name,
      tz.TZDateTime.from(task.date!, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          notificationChannelId,
          notificationChannelName,
          channelDescription: notificationChannelDescription,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: '$scheme/tasks/${task.id}',
    );
  }

  @override
  Future<bool?>? requestPermissions() {
    return _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  @override
  Future<bool> isGranted() {
    return Permission.notification.isGranted;
  }

  @override
  Future<bool> changePermission() {
    return openAppSettings();
  }
}
