import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky/domain/models/task.dart';
import 'package:tasky/infrastructure/repositories/task_repository.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final TaskRepository _taskRepository;

   StreamSubscription<List<Task>>? _tasksSubscr;

  TasksCubit(this._taskRepository) : super(TasksLoading());

  void watchUncompleted() {
    _tasksSubscr?.cancel();
    _tasksSubscr = _taskRepository.watchUncompletedTasks().listen((tasks) {
      if (tasks.isEmpty) {
        emit(TasksEmpty());
      } else {
        emit(TasksLoaded(tasks));
      }
    });
  }

  void watchAll() {
    _tasksSubscr?.cancel();
    _tasksSubscr = _taskRepository.watchAllTasks().listen((tasks) {
      if (tasks.isEmpty) {
        emit(TasksEmpty());
      } else {
        emit(TasksLoaded(tasks));
      }
    });
  }

  Future<void> deleteTask(int id) async {
    await _taskRepository.deleteTask(id);
  }

  Future<void> updateTask(Task task) async {
    await _taskRepository.updateTask(task);
  }

  @override
  Future<void> close() {
    _tasksSubscr?.cancel();
    return super.close();
  }
}
