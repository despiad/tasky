import 'package:tasky/domain/models/task.dart';
import 'package:tasky/infrastructure/database/database.dart';

abstract class TaskLocalDatasource {
  Future<List<Task>> getAllTasks();

  Stream<List<Task>> watchAllTasks();

  Stream<List<Task>> watchUncompletedTasks();

  Future<void> createTask(Task task);

  Future<Task> getTaskById(int id);

  Future<void> updateTask(Task task);

  Future<void> deleteTask(int id);
}

class TaskLocalDataSourceImpl implements TaskLocalDatasource {
  final AppDatabase _appDatabase;

  TaskLocalDataSourceImpl(this._appDatabase);

  @override
  Future<void> createTask(Task task) async {
    return _appDatabase.taskDao.insertTask(task);
  }

  @override
  Future<void> deleteTask(int id) {
    return _appDatabase.taskDao.deleteTask(id);
  }

  @override
  Future<List<Task>> getAllTasks() {
    return _appDatabase.taskDao.getAllTasks();
  }

  @override
  Future<Task> getTaskById(int id) {
    return _appDatabase.taskDao.getTaskById(id);
  }

  @override
  Future<void> updateTask(Task task) {
    return _appDatabase.taskDao.updateTask(task);
  }

  @override
  Stream<List<Task>> watchAllTasks() {
    return _appDatabase.taskDao.watchAllTasks();
  }

  @override
  Stream<List<Task>> watchUncompletedTasks() {
    return _appDatabase.taskDao.watchUncompletedTasks();
  }
}
