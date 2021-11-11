import 'package:flutter/material.dart';
import 'package:tasky/injection_container.dart';
import 'package:tasky/router/app_router.gr.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRouter = sl.get<AppRouter>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
