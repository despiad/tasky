import 'package:drift/drift.dart';
import 'package:tasky/domain/mappers/task_mapper.dart';
import 'package:tasky/domain/models/task.dart';
import 'package:tasky/domain/tables/tasks_table.dart';
import 'package:tasky/infrastructure/database/database.dart';

part 'task_dao.g.dart';

@DriftAccessor(tables: [DBTasks])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  final AppDatabase db;

  TaskDao(this.db) : super(db);

  Future<List<Task>> getAllTasks() =>
      select(dBTasks).map((dbTask) => toTask(dbTask)).get();

  Stream<List<Task>> watchAllTasks() {
    return (select(dBTasks)
          ..orderBy([
            (t) => OrderingTerm(
                expression: t.date.isNull(), mode: OrderingMode.asc),
            (t) =>
                OrderingTerm(expression: t.isCompleted, mode: OrderingMode.asc),
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc),
            (t) => OrderingTerm(expression: t.name),
          ]))
        .watch()
        .map((dbList) => toListTasks(dbList));
  }

  Stream<List<Task>> watchUncompletedTasks() {
    return (select(dBTasks)
          ..orderBy([
            (t) => OrderingTerm(
                expression: t.date.isNull(), mode: OrderingMode.asc),
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc),
            (t) => OrderingTerm(expression: t.name),
          ])
          ..where((t) => t.isCompleted.equals(false)))
        .watch()
        .map((dbList) => toListTasks(dbList));
  }

  Future<Task> getTaskById(int taskId) {
    return (select(dBTasks)..where((t) => t.id.equals(taskId)))
        .map((dbTask) => toTask(dbTask))
        .getSingle();
  }

  Future<void> insertTask(Task task) => into(dBTasks).insert(
        DBTasksCompanion(
          name: Value(task.name),
          date: Value(task.date),
        ),
      );

  Future<void> updateTask(Task task) => update(dBTasks).replace(toDBTask(task));

  Future<int> deleteTask(int idToDelete) =>
      (delete(dBTasks)..where((t) => t.id.equals(idToDelete))).go();
}
