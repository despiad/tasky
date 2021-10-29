import 'dart:io';

import 'package:drift/backends.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:tasky/domain/dao/task_dao.dart';
import 'package:tasky/domain/tables/tasks_table.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [DBTasks],
  daos: [TaskDao]
)
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(LazyDatabase(
          () async {
            return NativeDatabase(
              File('db.sqlite'),
              logStatements: true,
            );
          },
        ));

  @override
  int get schemaVersion => 1;
}
