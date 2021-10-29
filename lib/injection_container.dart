import 'package:get_it/get_it.dart';
import 'package:tasky/infrastructure/database/database.dart';
import 'package:tasky/infrastructure/datasources/task_local_datasource.dart';
import 'package:tasky/infrastructure/repositories/task_repository.dart';

final sl = GetIt.instance;

void setup() {
  // Clients
  sl.registerSingleton<AppDatabase>(AppDatabase());

  // DataSources
  sl.registerLazySingleton<TaskLocalDatasource>(
      () => TaskLocalDataSourceImpl(sl()));

  // Repositories
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));

  // Blocs/Cubits

}
