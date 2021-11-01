import 'package:flutter/material.dart';
import 'package:tasky/router/app_router.gr.dart';
import 'package:tasky/router/guards/edit_screen_guard.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter(editScreenGuard: EditScreenGuard());

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
