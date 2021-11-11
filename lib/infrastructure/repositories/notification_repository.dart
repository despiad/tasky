import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tasky/domain/models/task.dart';
import 'package:timezone/timezone.dart' as tz;

abstract class NotificationRepository {
  Future<bool?>? requestPermissions();

  Future<void> createNotificationFromTask(Task task);

  Future<void> cancelNotification(int id);
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
          'TaskyChannelId',
          'Tasky',
          channelDescription: 'Tasky notifications settings',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: '/tasks/${task.id}',
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
}
