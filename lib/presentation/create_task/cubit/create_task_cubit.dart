import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky/domain/models/task.dart';
import 'package:tasky/infrastructure/repositories/settings_repository.dart';
import 'package:tasky/infrastructure/repositories/task_repository.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  final TaskRepository _taskRepository;
  final SettingsRepository _notificationRepository;

  CreateTaskCubit(this._taskRepository, this._notificationRepository)
      : super(CreateTaskInitial());

  void saveNewTask(String name, DateTime? date) async {
    emit(CreateTaskLoading());
    try {
      final task = Task(
        name: name,
        date: date,
      );
      final id = await _taskRepository.createTask(task);
      if (date != null) {
        await _notificationRepository.createNotificationFromTask(task.copyWith(
          id: id,
          date: date,
        ));
      }
      emit(CreateTaskSuccess());
    } catch (e) {
      emit(CreateTaskError(e.toString()));
    }
  }

  void updateTask(Task task) async {
    emit(CreateTaskLoading());
    try {
      if (task.date == null) {
        await _notificationRepository.cancelNotification(task.id);
      } else {
        await _notificationRepository.createNotificationFromTask(task);
      }
      _taskRepository.updateTask(task);
      emit(CreateTaskSuccess());
    } catch (e) {
      emit(CreateTaskError(e.toString()));
    }
  }
}
