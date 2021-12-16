import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/domain/dao/setting_dao.dart';
import 'package:tasky/domain/dao/task_dao.dart';
import 'package:tasky/domain/tables/settings_table.dart';
import 'package:tasky/domain/tables/tasks_table.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(tables: [DBTasks, DBSettings], daos: [TaskDao, SettingDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(LazyDatabase(
          () async {
            final dbFolder = await getApplicationDocumentsDirectory();
            final file = File(p.join(dbFolder.path, 'db.sqlite'));
            return NativeDatabase(file);
          },
        ));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await settingDao.into(dBSettings).insert(const DBSettingsCompanion());
        },
        onUpgrade: (Migrator m, int from, int to) async {
          m.deleteTable(dBTasks.actualTableName);
          m.deleteTable(dBSettings.actualTableName);
          m.createAll();
        },
      );
}
