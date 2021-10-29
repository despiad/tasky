import 'package:drift/drift.dart';
import 'package:tasky/domain/models/task.dart';
import 'package:tasky/infrastructure/database/database.dart';

Task toTask(DBTask dbTask) {
  return Task(
    id: dbTask.id,
    name: dbTask.name,
    date: dbTask.date,
    isCompleted: dbTask.isCompleted,
  );
}

DBTask toDBTask(Task task) {
  return DBTask(
    id: task.id,
    name: task.name,
    isCompleted: task.isCompleted,
    date: task.date,
  );
}

List<Task> toListTasks(List<DBTask> tasks) {
  return tasks
      .map(
        (e) => toTask(e),
      )
      .toList();
}

List<DBTask> toListDBTasks(List<Task> tasks) {
  return tasks
      .map(
        (e) => toDBTask(e),
      )
      .toList();
}
