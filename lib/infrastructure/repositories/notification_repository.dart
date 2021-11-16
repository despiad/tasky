import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tasky/domain/models/task.dart';
import 'package:tasky/utils/constants.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

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
  Future<void> createNotificationFromTask(Task task) async {
    final imagePath = await _getPathFromAsset('notification_image.jpeg');
    return _notificationsPlugin.zonedSchedule(
      task.id,
      'Task ${task.id} is about to start',
      task.name,
      tz.TZDateTime.from(task.date!, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          notificationChannelId,
          notificationChannelName,
          channelDescription: notificationChannelDescription,
          styleInformation: BigPictureStyleInformation(
            FilePathAndroidBitmap(imagePath),
          ),
        ),
        iOS: IOSNotificationDetails(
          attachments: [
            IOSNotificationAttachment(imagePath),
          ],
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

  Future<String> _getPathFromAsset(String path) async {
    final byteData = await rootBundle.load('assets/images/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file.path;
  }
}
