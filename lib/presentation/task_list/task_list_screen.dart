import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/injection_container.dart';
import 'package:tasky/presentation/task_list/widgets/task_item.dart';
import 'package:tasky/router/app_router.gr.dart';
import 'package:tasky/presentation/task_list/cubit/tasks_cubit.dart';

class TaskListScreen extends StatelessWidget {
  TaskListScreen({Key? key}) : super(key: key);

  final ValueNotifier<bool> _showUncompleted = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<TasksCubit>()..watchAll(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: ValueListenableBuilder(
                  valueListenable: _showUncompleted,
                  builder: (_, __, ___) {
                    return Text(
                      _showUncompleted.value
                          ? 'Uncompleted Tasks'
                          : 'All Tasks',
                    );
                  }),
              actions: [
                ValueListenableBuilder<bool>(
                  valueListenable: _showUncompleted,
                  builder: (_, __, ___) {
                    return Switch(
                      value: _showUncompleted.value,
                      onChanged: (value) {
                        _showUncompleted.value = value;
                        value
                            ? context.read<TasksCubit>().watchUncompleted()
                            : context.read<TasksCubit>().watchAll();
                      },
                    );
                  },
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                context.router.push(CreateTask());
              },
            ),
            body: BlocConsumer<TasksCubit, TasksState>(
              listener: (context, state) {
                if (state is TasksError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is TasksEmpty) {
                  return const Center(
                    child: Text('Empty'),
                  );
                } else if (state is TasksLoaded) {
                  return ListView.separated(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      final task = state.tasks[index];
                      return TaskItem(
                        key: ValueKey<int>(task.id),
                        task: task,
                        onDelete: (_) {
                          context.read<TasksCubit>().deleteTask(task.id);
                        },
                        onCheckboxChanged: (value) {
                          final updatedTask = task.copyWith(isCompleted: value);
                          context.read<TasksCubit>().updateTask(updatedTask);
                        },
                        onTap: () {
                          context.router.push(
                            TaskDetailsRoute(taskId: task.id),
                          );
                        },
                        onLongPress: () {
                          context.router.push(
                            EditTask(task: task),
                          );
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 1,
                        thickness: 1,
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
