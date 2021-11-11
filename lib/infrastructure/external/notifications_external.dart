import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:tasky/router/app_router.gr.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationExternal {
  final AppRouter _appRouter;

  NotificationExternal(this._appRouter);

  Future<FlutterLocalNotificationsPlugin> init() async {
    tz.initializeTimeZones();
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('notification_icon');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) {
        if (payload != null) {
          _appRouter.navigateNamed(payload, includePrefixMatches: true);
        }
      },
    );
    final details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null) {
      final payload = details.payload;
      if (payload != null) {
        _appRouter.pushNamed(payload, includePrefixMatches: true);
      }
    }
    return flutterLocalNotificationsPlugin;
  }
}
