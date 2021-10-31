import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/injection_container.dart';
import 'package:tasky/presentation/router/app_router.gr.dart';
import 'package:tasky/presentation/task_list/cubit/tasks_cubit.dart';

class TaskListScreen extends StatelessWidget {
  TaskListScreen({Key? key}) : super(key: key);

  final ValueNotifier<bool> _showCompleted = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          ValueListenableBuilder<bool>(
            valueListenable: _showCompleted,
            builder: (_, __, ___) {
              return Switch(
                value: _showCompleted.value,
                onChanged: (_) {
                  _showCompleted.value = !_showCompleted.value;
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
      body: BlocProvider(
        create: (context) =>
            sl.get<TasksCubit>()..toggleCompleted(_showCompleted.value),
        child: Builder(builder: (context) {
          return BlocConsumer<TasksCubit, TasksState>(
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
                  child: Text(
                      'There are no tasks, so it\'s time to create new one'),
                );
              } else if (state is TasksLoaded) {
                return ListView();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        }),
      ),
    );
  }
}
