import 'package:drift/drift.dart';
import 'package:tasky/domain/mappers/settings_mapper.dart';
import 'package:tasky/domain/models/settings.dart';
import 'package:tasky/domain/tables/settings_table.dart';
import 'package:tasky/infrastructure/database/database.dart';

part 'settings_dao.g.dart';

@DriftAccessor(tables: [DBSettings])
class SettingDao extends DatabaseAccessor<AppDatabase> with _$SettingDaoMixin {
  final AppDatabase db;

  SettingDao(this.db) : super(db);

  Stream<Settings> getSettings() {
    return select(dBSettings)
        .map((p0) => Settings(
              locale: 'ru',
              isNotificationPermitted: false,
              isDarkTheme: false,
            ))
        .watchSingle();
  }

  Future<void> updateSettings(Settings settings) =>
      update(dBSettings).replace(toDBSettings(settings));
}
