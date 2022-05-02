part of 'tasks_cubit.dart';

@immutable
abstract class TasksState {}

class TasksLoading extends TasksState {}

class TasksEmpty extends TasksState {}

class TasksLoaded extends TasksState {
  final List<Task> tasks;

  TasksLoaded(this.tasks);
}

class TasksError extends TasksState {
  final String message;

  TasksError(this.message);
}
