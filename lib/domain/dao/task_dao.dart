import 'package:moor_flutter/moor_flutter.dart';
import 'package:tasky/domain/tables/tasks_table.dart';
import 'package:tasky/infrastructure/database/database.dart';

part 'task_dao.g.dart';

@UseDao(tables: [Tasks])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  final AppDatabase db;

  TaskDao(this.db) : super(db);

  Future<List<Task>> getAllTasks() => select(tasks).get();

  Stream<List<Task>> watchAllTasks() {
    return (select(tasks)
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
            (t) => OrderingTerm(expression: t.name),
          ]))
        .watch();
  }

  Stream<List<Task>> watchCompletedTasks() {
    return (select(tasks)
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
            (t) => OrderingTerm(expression: t.name),
          ])
          ..where((t) => t.isCompleted.equals(true)))
        .watch();
  }

  Future<Task> getTaskById(int taskId) {
    return (select(tasks)..where((t) => t.id.equals(taskId))).getSingle();
  }

  Future<void> insertTask(Task task) => into(tasks).insert(task);

  Future<void> updateTask(Task task) => update(tasks).replace(task);

  Future<void> deleteTask(Task task) => delete(tasks).delete(task);
}
