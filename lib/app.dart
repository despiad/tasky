import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/injection_container.dart';
import 'package:tasky/presentation/deeplinks/cubit/deeplink_cubit.dart';
import 'package:tasky/presentation/notifications/cubit/notification_cubit.dart';
import 'package:tasky/router/app_router.gr.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRouter = sl.get<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DeeplinkCubit>(
          create: (context) => sl.get<DeeplinkCubit>()..initLinks(),
        ),
        BlocProvider<NotificationCubit>(
          create: (context) => sl.get<NotificationCubit>()..isGranted(),
        ),
      ],
      child: MaterialApp.router(
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
