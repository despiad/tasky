import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

class TaskDetailsScreen extends StatelessWidget {
  final int taskId;

  const TaskDetailsScreen({@PathParam() required this.taskId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
