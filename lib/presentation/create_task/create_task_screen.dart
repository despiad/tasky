import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:tasky/domain/models/task.dart';

class CreateTaskScreen extends StatelessWidget {
  final Task? task;
  final int? taskId;

  const CreateTaskScreen({@PathParam() this.taskId, this.task, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Create'),
      ),
    );
  }
}
