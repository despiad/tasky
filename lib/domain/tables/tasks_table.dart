import 'package:moor_flutter/moor_flutter.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 50)();

  DateTimeColumn get date => dateTime().nullable()();

  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
}
