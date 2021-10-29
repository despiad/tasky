import 'package:drift/drift.dart';
import 'package:tasky/domain/models/task.dart';
import 'package:tasky/infrastructure/database/database.dart';

class DBTasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 50)();

  DateTimeColumn get date => dateTime().nullable()();

  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
}
