import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:tasky/app_config.dart';
import 'package:tasky/infrastructure/database/database.dart';
import 'package:tasky/infrastructure/datasources/settings_local_datasource.dart';
import 'package:tasky/infrastructure/datasources/task_local_datasource.dart';
import 'package:tasky/infrastructure/external/notifications_external.dart';
import 'package:tasky/infrastructure/repositories/settings_repository.dart';
import 'package:tasky/infrastructure/repositories/task_repository.dart';
import 'package:tasky/presentation/create_task/cubit/create_task_cubit.dart';
import 'package:tasky/presentation/deeplinks/cubit/deeplink_cubit.dart';
import 'package:tasky/presentation/notifications/cubit/notification_cubit.dart';
import 'package:tasky/presentation/settings/cubit/settings_cubit.dart';
import 'package:tasky/presentation/task_details/cubit/task_details_cubit.dart';
import 'package:tasky/presentation/task_list/cubit/tasks_cubit.dart';
import 'package:tasky/router/app_router.gr.dart';

final sl = GetIt.instance;

void setupDependencies() async {
  // External
  sl.registerSingleton<AppRouter>(AppRouter());

  sl.registerSingletonAsync<FlutterLocalNotificationsPlugin>(
      () async => await NotificationExternal(sl()).init());

  // Clients
  sl.registerSingleton<AppDatabase>(AppDatabase());
  sl.registerSingleton<AppConfig>(AppConfig());

  // DataSources
  sl.registerLazySingleton<TaskLocalDatasource>(
      () => TaskLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<SettingsLocalDatasource>(
      () => SettingsLocalDatasourceImpl(sl()));

  // Repositories
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));
  await sl.isReady<FlutterLocalNotificationsPlugin>();
  sl.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(sl(), sl()));

  // Blocs/Cubits
  sl.registerFactory<TasksCubit>(() => TasksCubit(sl()));
  sl.registerFactory<CreateTaskCubit>(() => CreateTaskCubit(sl(), sl()));
  sl.registerFactory<TaskDetailsCubit>(() => TaskDetailsCubit(sl()));
  sl.registerFactory<NotificationCubit>(() => NotificationCubit(sl()));
  sl.registerFactory<DeeplinkCubit>(() => DeeplinkCubit(sl()));

  sl.registerFactory<SettingsCubit>(() => SettingsCubit(sl()));
}
