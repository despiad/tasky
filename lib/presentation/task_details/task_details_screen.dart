import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/injection_container.dart';
import 'package:tasky/presentation/task_details/cubit/task_details_cubit.dart';
import 'package:auto_route/auto_route.dart';

class TaskDetailsScreen extends StatelessWidget {
  final int taskId;

  const TaskDetailsScreen({@PathParam() required this.taskId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: BlocProvider(
        create: (context) => sl.get<TaskDetailsCubit>()..getTaskById(taskId),
        child: Builder(builder: (context) {
          return BlocConsumer<TaskDetailsCubit, TaskDetailsState>(
            listener: (context, state) {
              if (state is TaskDetailsError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is TaskDetailsSuccess) {
                final task = state.task;
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        task.id.toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        task.name,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        task.date.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
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
