import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky/domain/models/task.dart';
import 'package:tasky/infrastructure/repositories/task_repository.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final TaskRepository _taskRepository;

  late StreamSubscription<List<Task>> _tasksSubscr;

  TasksCubit(this._taskRepository) : super(TasksLoading());

  void toggleCompleted({required bool showCompleted}) {
    if (showCompleted) {
      _tasksSubscr = _taskRepository.watchCompletedTasks().listen((tasks) {
        if (tasks.isEmpty) {
          emit(TasksEmpty());
        } else {
          emit(TasksLoaded(tasks));
        }
      });
    } else {
      _tasksSubscr = _taskRepository.watchAllTasks().listen((tasks) {
        if (tasks.isEmpty) {
          emit(TasksEmpty());
        } else {
          emit(TasksLoaded(tasks));
        }
      });
    }
  }

  void deleteTask(int id) {
    _taskRepository.deleteTask(id);
  }

  void updateTask(Task task) {
    _taskRepository.updateTask(task);
  }

  @override
  Future<void> close() {
    _tasksSubscr.cancel();
    return super.close();
  }
}
