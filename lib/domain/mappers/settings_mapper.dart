import 'package:tasky/domain/models/settings.dart';
import 'package:tasky/infrastructure/database/database.dart';

Settings toSettings(DBSetting dbSetting) {
  return Settings(
    isDarkTheme: dbSetting.isDarkTheme,
    isNotificationPermitted: dbSetting.isNotificationsPermitted,
    locale: dbSetting.locale,
  );
}

DBSetting toDBSettings(Settings settings) {
  return DBSetting(
    id: 1,
    isDarkTheme: settings.isDarkTheme,
    isNotificationsPermitted: settings.isNotificationPermitted,
    locale: settings.locale,
  );
}
