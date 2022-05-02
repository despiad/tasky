import 'package:tasky/domain/models/settings.dart';
import 'package:tasky/infrastructure/database/database.dart';

abstract class SettingsLocalDatasource {
  Stream<Settings> watchSettings();

  Future<void> updateSettings(Settings updatedSettings);
}

class SettingsLocalDatasourceImpl implements SettingsLocalDatasource {
  final AppDatabase _appDatabase;

  SettingsLocalDatasourceImpl(this._appDatabase);

  @override
  Future<void> updateSettings(Settings updatedSettings) {
    return _appDatabase.settingDao.updateSettings(updatedSettings);
  }

  @override
  Stream<Settings> watchSettings() {
    return _appDatabase.settingDao.watchSettings();
  }
}
