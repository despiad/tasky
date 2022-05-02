import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky/domain/models/task.dart';
import 'package:tasky/infrastructure/repositories/task_repository.dart';

part 'task_details_state.dart';

class TaskDetailsCubit extends Cubit<TaskDetailsState> {
  final TaskRepository _taskRepository;

  TaskDetailsCubit(this._taskRepository) : super(TaskDetailsLoading());

  void getTaskById(int id) async {
    try {
      final task = await _taskRepository.getTaskById(id);
      emit(TaskDetailsSuccess(task));
    } catch (e) {
      emit(TaskDetailsError(e.toString()));
    }
  }
}
