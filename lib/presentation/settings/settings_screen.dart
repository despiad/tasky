import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/presentation/notifications/cubit/notification_cubit.dart';

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
      context.read<NotificationCubit>().isGranted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocListener<NotificationCubit, NotificationState>(
        listener: (context, state) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message!),
            ));
          }
        },
        child: Column(
          children: [
            BlocSelector<NotificationCubit, NotificationState, bool>(
              selector: (state) {
                return state.isPermitted;
              },
              builder: (context, state) {
                return CheckboxListTile(
                  title: const Text('Allow notifications'),
                  value: state,
                  onChanged: (_) async {
                    await context.read<NotificationCubit>().changePermission();
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
