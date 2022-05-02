import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/presentation/deeplinks/cubit/deeplink_cubit.dart';
import 'package:tasky/router/app_router.gr.dart';
import 'package:tasky/localization/localization_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DeeplinkCubit, DeeplinkState>(
          listener: (context, state) {
            if (state is DeeplinkSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    LocaleKeys.main_screen_deeplink_success.tr(
                      namedArgs: {'deeplink': state.parsedPath},
                    ),
                  ),
                ),
              );
            }
            if (state is DeeplinkError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                ),
              );
            }
          },
        ),
      ],
      child: AutoTabsScaffold(
        routes: const [
          TasksRouter(),
          SettingsRouter(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.task),
                label: LocaleKeys.main_screen_tasks_tab.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: LocaleKeys.main_screen_settings_tab.tr(),
              ),
            ],
          );
        },
      ),
    );
  }
}
