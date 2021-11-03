import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky/domain/models/task.dart';
import 'package:tasky/infrastructure/repositories/task_repository.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  final TaskRepository _taskRepository;

  CreateTaskCubit(this._taskRepository) : super(CreateTaskInitial());

  void saveNewTask(String name, DateTime? date) {
    emit(CreateTaskLoading());
    try {
      final task = Task(
        name: name,
        date: date,
      );
      _taskRepository.createTask(task);
      emit(CreateTaskSuccess());
    } catch (e) {
      emit(CreateTaskError(e.toString()));
    }
  }

  void updateTask() {}
}
