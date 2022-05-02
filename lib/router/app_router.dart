import 'package:auto_route/auto_route.dart';
import 'package:tasky/presentation/create_task/create_task_screen.dart';
import 'package:tasky/presentation/home/home_screen.dart';
import 'package:tasky/presentation/settings/settings_screen.dart';
import 'package:tasky/presentation/task_details/task_details_screen.dart';
import 'package:tasky/presentation/task_list/task_list_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: [
    AutoRoute(
      path: '/',
      page: HomeScreen,
      children: [
        AutoRoute(
          path: 'tasks',
          name: 'TasksRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: TaskListScreen),
            AutoRoute(
              name: 'createTask',
              path: 'create',
              page: CreateTaskScreen,
              fullscreenDialog: true,
            ),
            AutoRoute(
              name: 'editTask',
              path: 'edit',
              page: CreateTaskScreen,
              fullscreenDialog: true,
            ),
            AutoRoute(
              path: ':taskId',
              page: TaskDetailsScreen,
            ),

            // RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          path: "settings",
          name: "SettingsRouter",
          page: SettingsScreen,
        ),
      ],
    )
  ],
)
class $AppRouter {}
