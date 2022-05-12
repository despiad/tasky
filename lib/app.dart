import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/injection_container.dart';
import 'package:tasky/presentation/deeplinks/cubit/deeplink_cubit.dart';
import 'package:tasky/presentation/settings/cubit/settings_cubit.dart';
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
        BlocProvider<SettingsCubit>(
          create: (context) => sl.get<SettingsCubit>()
            ..watchSettings()
            ..isNotificationsGranted(),
        ),
      ],
      child: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          context.setLocale(state.locale);
        },
        listenWhen: (previous, current) => previous.locale != current.locale,
        child: MaterialApp.router(
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          themeMode: ThemeMode.light,
          darkTheme: ThemeData.dark().copyWith(
              elevatedButtonTheme: ThemeData.dark().elevatedButtonTheme),
          theme: ThemeData.light(),
        ),
      ),
    );
  }
}
