import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:tasky/presentation/router/app_router.gr.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(Create());
        },
      ),
      body: Center(
        child: Text('List'),
      ),
    );
  }
}
