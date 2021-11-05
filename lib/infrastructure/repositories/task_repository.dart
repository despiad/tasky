import 'package:tasky/domain/models/task.dart';
import 'package:tasky/infrastructure/datasources/task_local_datasource.dart';

abstract class TaskRepository {
  Future<List<Task>> getAllTasks();

  Stream<List<Task>> watchAllTasks();

  Stream<List<Task>> watchUncompletedTasks();

  Future<void> createTask(Task task);

  Future<Task> getTaskById(int id);

  Future<void> updateTask(Task task);

  Future<void> deleteTask(int id);
}

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDatasource _localDatasource;

  TaskRepositoryImpl(this._localDatasource);

  @override
  Future<void> createTask(Task task) async {
    return _localDatasource.createTask(task);
  }

  @override
  Future<void> deleteTask(int id) {
    return _localDatasource.deleteTask(id);
  }

  @override
  Future<List<Task>> getAllTasks() {
    return _localDatasource.getAllTasks();
  }

  @override
  Future<Task> getTaskById(int id) {
    return _localDatasource.getTaskById(id);
  }

  @override
  Future<void> updateTask(Task task) {
    return _localDatasource.updateTask(task);
  }

  @override
  Stream<List<Task>> watchAllTasks() {
    return _localDatasource.watchAllTasks();
  }

  @override
  Stream<List<Task>> watchUncompletedTasks() {
    return _localDatasource.watchUncompletedTasks();
  }
}
