// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i7;

import '../domain/models/task.dart' as _i8;
import '../presentation/create_task/create_task_screen.dart' as _i5;
import '../presentation/home/home_screen.dart' as _i1;
import '../presentation/settings/settings_screen.dart' as _i3;
import '../presentation/task_details/task_details_screen.dart' as _i6;
import '../presentation/task_list/task_list_screen.dart' as _i4;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    TasksRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    SettingsRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.SettingsScreen());
    },
    TaskListRoute.name: (routeData) {
      final args = routeData.argsAs<TaskListRouteArgs>(
          orElse: () => const TaskListRouteArgs());
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.TaskListScreen(key: args.key));
    },
    CreateTask.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<CreateTaskArgs>(
          orElse: () => CreateTaskArgs(task: queryParams.get('task')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.CreateTaskScreen(task: args.task, key: args.key),
          fullscreenDialog: true);
    },
    EditTask.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<EditTaskArgs>(
          orElse: () => EditTaskArgs(task: queryParams.get('task')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.CreateTaskScreen(task: args.task, key: args.key),
          fullscreenDialog: true);
    },
    TaskDetailsRoute.name: (routeData) {
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<TaskDetailsRouteArgs>(
          orElse: () =>
              TaskDetailsRouteArgs(taskId: pathParams.getInt('taskId')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.TaskDetailsScreen(taskId: args.taskId, key: args.key));
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(HomeRoute.name, path: '/', children: [
          _i2.RouteConfig(TasksRouter.name,
              path: 'tasks',
              parent: HomeRoute.name,
              children: [
                _i2.RouteConfig(TaskListRoute.name,
                    path: '', parent: TasksRouter.name),
                _i2.RouteConfig(CreateTask.name,
                    path: 'create', parent: TasksRouter.name),
                _i2.RouteConfig(EditTask.name,
                    path: 'edit', parent: TasksRouter.name),
                _i2.RouteConfig(TaskDetailsRoute.name,
                    path: ':taskId', parent: TasksRouter.name)
              ]),
          _i2.RouteConfig(SettingsRouter.name,
              path: 'settings', parent: HomeRoute.name)
        ])
      ];
}

/// generated route for [_i1.HomeScreen]
class HomeRoute extends _i2.PageRouteInfo<void> {
  const HomeRoute({List<_i2.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for [_i2.EmptyRouterPage]
class TasksRouter extends _i2.PageRouteInfo<void> {
  const TasksRouter({List<_i2.PageRouteInfo>? children})
      : super(name, path: 'tasks', initialChildren: children);

  static const String name = 'TasksRouter';
}

/// generated route for [_i3.SettingsScreen]
class SettingsRouter extends _i2.PageRouteInfo<void> {
  const SettingsRouter() : super(name, path: 'settings');

  static const String name = 'SettingsRouter';
}

/// generated route for [_i4.TaskListScreen]
class TaskListRoute extends _i2.PageRouteInfo<TaskListRouteArgs> {
  TaskListRoute({_i7.Key? key})
      : super(name, path: '', args: TaskListRouteArgs(key: key));

  static const String name = 'TaskListRoute';
}

class TaskListRouteArgs {
  const TaskListRouteArgs({this.key});

  final _i7.Key? key;
}

/// generated route for [_i5.CreateTaskScreen]
class CreateTask extends _i2.PageRouteInfo<CreateTaskArgs> {
  CreateTask({_i8.Task? task, _i7.Key? key})
      : super(name,
            path: 'create',
            args: CreateTaskArgs(task: task, key: key),
            rawQueryParams: {'task': task});

  static const String name = 'CreateTask';
}

class CreateTaskArgs {
  const CreateTaskArgs({this.task, this.key});

  final _i8.Task? task;

  final _i7.Key? key;
}

/// generated route for [_i5.CreateTaskScreen]
class EditTask extends _i2.PageRouteInfo<EditTaskArgs> {
  EditTask({_i8.Task? task, _i7.Key? key})
      : super(name,
            path: 'edit',
            args: EditTaskArgs(task: task, key: key),
            rawQueryParams: {'task': task});

  static const String name = 'EditTask';
}

class EditTaskArgs {
  const EditTaskArgs({this.task, this.key});

  final _i8.Task? task;

  final _i7.Key? key;
}

/// generated route for [_i6.TaskDetailsScreen]
class TaskDetailsRoute extends _i2.PageRouteInfo<TaskDetailsRouteArgs> {
  TaskDetailsRoute({required int taskId, _i7.Key? key})
      : super(name,
            path: ':taskId',
            args: TaskDetailsRouteArgs(taskId: taskId, key: key),
            rawPathParams: {'taskId': taskId});

  static const String name = 'TaskDetailsRoute';
}

class TaskDetailsRouteArgs {
  const TaskDetailsRouteArgs({required this.taskId, this.key});

  final int taskId;

  final _i7.Key? key;
}
