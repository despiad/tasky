import 'dart:io';

import 'package:drift/backends.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/domain/dao/task_dao.dart';
import 'package:tasky/domain/tables/tasks_table.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(tables: [DBTasks], daos: [TaskDao])
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
}
