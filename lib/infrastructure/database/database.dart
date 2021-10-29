import 'package:moor_flutter/moor_flutter.dart';
import 'package:tasky/domain/dao/task_dao.dart';
import 'package:tasky/domain/tables/tasks_table.dart';

part 'database.g.dart';

@UseMoor(tables: [Tasks], daos: [TaskDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          logStatements: true,
        ));

  @override
  int get schemaVersion => 1;
}
