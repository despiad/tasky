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
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                LocaleKeys.settings_screen_language_field.tr(),
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            BlocSelector<SettingsCubit, SettingsState, Locale>(
              selector: (state) {
                return state.locale;
              },
              builder: (context, stateLocale) {
                return Row(
                  children: context.supportedLocales
                      .map(
                        (locale) => Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<SettingsCubit>()
                                    .changeLocale(locale);
                              },
                              child: Text(
                                locale.languageCode,
                                style: TextStyle(
                                  color: stateLocale == locale
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onSecondary
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor: stateLocale == locale
                                    ? MaterialStateProperty.all<Color>(
                                        Theme.of(context).colorScheme.secondary)
                                    : MaterialStateProperty.all<Color>(
                                        Theme.of(context).colorScheme.surface),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            BlocSelector<SettingsCubit, SettingsState, bool>(
              selector: (state) {
                return state.isNotificationsPermitted;
              },
              builder: (context, isNotificationsPermitted) {
                return CheckboxListTile(
                  title:
                      Text(LocaleKeys.settings_screen_notifications_field.tr()),
                  value: isNotificationsPermitted,
                  onChanged: (_) async {
                    await context.read<SettingsCubit>().changePermission();
                  },
                );
              },
            ),
            BlocSelector<SettingsCubit, SettingsState, bool>(
              selector: (state) {
                return state.isDarkTheme;
              },
              builder: (context, isDarkTheme) {
                return SwitchListTile(
                  title: Text(LocaleKeys.settings_screen_theme_field.tr()),
                  onChanged: (value) async {
                    await context.read<SettingsCubit>().changeTheme(value);
                  },
                  value: isDarkTheme,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
