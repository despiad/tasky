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
          create: (context) =>
              sl.get<SettingsCubit>()..isNotificationsGranted(),
        ),
      ],
      child: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) async {
          await context.setLocale(state.locale);
        },
        listenWhen: (previous, current) => previous.locale != current.locale,
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return MaterialApp.router(
              key: ValueKey('${context.locale}'),
              routerDelegate: _appRouter.delegate(),
              routeInformationParser: _appRouter.defaultRouteParser(),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              themeMode: state.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
              darkTheme: ThemeData.dark(),
              theme: ThemeData.light(),
            );
          },
        ),
      ),
    );
  }
}
