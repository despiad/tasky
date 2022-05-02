import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/domain/models/task.dart';
import 'package:tasky/injection_container.dart';
import 'package:tasky/presentation/create_task/cubit/create_task_cubit.dart';
import 'package:tasky/utils/constants.dart';
import 'package:tasky/utils/validators.dart';
import 'package:auto_route/auto_route.dart';
import 'package:tasky/localization/localization_keys.g.dart';

class CreateTaskScreen extends StatefulWidget {
  final Task? task;

  const CreateTaskScreen({@QueryParam() this.task, Key? key}) : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<DateTime?> _pickedDate = ValueNotifier<DateTime?>(null);
  late TextEditingController _nameController;

  Task? get task => widget.task;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: task?.name ?? '');
    _pickedDate.value = task?.date;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          task != null
              ? LocaleKeys.update_screen_app_bar.tr()
              : LocaleKeys.create_screen_app_bar.tr(),
        ),
      ),
      body: BlocProvider(
        create: (context) => sl.get<CreateTaskCubit>(),
        child: Builder(builder: (context) {
          return BlocListener<CreateTaskCubit, CreateTaskState>(
            listener: (context, state) {
              if (state is CreateTaskLoading) {
                showDialog(
                  barrierColor: Colors.black38,
                  barrierDismissible: false,
                  context: context,
                  useRootNavigator: false,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              } else if (state is CreateTaskSuccess) {
                context.router.popUntilRoot();
              } else if (state is CreateTaskError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
                Future.delayed(
                  const Duration(milliseconds: 500),
                  () {
                    context.router.pop();
                  },
                );
              }
            },
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                        label: Text(
                          LocaleKeys.create_screen_name_field.tr(),
                        ),
                      ),
                      maxLength: taskNameMaxLength,
                      controller: _nameController,
                      validator: validateTaskName,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ValueListenableBuilder(
                      valueListenable: _pickedDate,
                      builder: (_, __, ___) {
                        return _pickedDate.value != null
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    padding: EdgeInsets.zero,
                                    splashRadius: 20,
                                    visualDensity: VisualDensity.comfortable,
                                    onPressed: () {
                                      _pickedDate.value = null;
                                    },
                                  ),
                                  Text(
                                    DateFormat.yMMMd()
                                        .add_Hm()
                                        .format(_pickedDate.value!),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  ElevatedButton(
                                    onPressed: _pickDateAndTime,
                                    child: Text(LocaleKeys
                                        .create_screen_change_date_button
                                        .tr()),
                                  ),
                                ],
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  final now = DateTime.now();
                                  _pickedDate.value = DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    now.hour,
                                    now.minute + 1,
                                  );
                                },
                                child: Text(LocaleKeys
                                    .create_screen_add_reminder_button
                                    .tr()),
                              );
                      },
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (task != null) {
                              final updatedTask = task!.copyWith(
                                name: _nameController.text,
                                date: _pickedDate.value,
                              );
                              context
                                  .read<CreateTaskCubit>()
                                  .updateTask(updatedTask);
                            } else {
                              context.read<CreateTaskCubit>().saveNewTask(
                                    _nameController.text,
                                    _pickedDate.value,
                                  );
                            }
                          }
                        },
                        child: Text(
                          task != null
                              ? LocaleKeys.update_screen_save_button.tr()
                              : LocaleKeys.create_screen_save_button.tr(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _pickDateAndTime() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _pickedDate.value!,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (date == null) {
      return;
    }
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_pickedDate.value!),
    );
    if (time == null) {
      return;
    }

    _pickedDate.value = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }
}
