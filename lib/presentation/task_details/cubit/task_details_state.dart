part of 'task_details_cubit.dart';

@immutable
abstract class TaskDetailsState {}

class TaskDetailsLoading extends TaskDetailsState {}

class TaskDetailsSuccess extends TaskDetailsState {
  final Task task;

  TaskDetailsSuccess(this.task);
}
class TaskDetailsError extends TaskDetailsState {
  final String message;

  TaskDetailsError(this.message);
}
