import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/localization/localization_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tasky/presentation/settings/cubit/settings_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (WidgetsBinding.instance!.lifecycleState == AppLifecycleState.resumed) {
      context.read<SettingsCubit>().isNotificationsGranted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.settings_screen_app_bar.tr()),
      ),
      body: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        listenWhen: (previous, current) => previous.message != current.message,
        child: Column(
          children: [
            Row(
              children: context.supportedLocales
                  .map(
                    (locale) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<SettingsCubit>().changeLocale(locale);
                          },
                          child: Text(locale.languageCode),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            BlocSelector<SettingsCubit, SettingsState, bool>(
              selector: (state) {
                return state.isNotificationsPermitted;
              },
              builder: (context, state) {
                return CheckboxListTile(
                  title:
                      Text(LocaleKeys.settings_screen_notifications_field.tr()),
                  value: state,
                  onChanged: (_) async {
                    await context.read<SettingsCubit>().changePermission();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
