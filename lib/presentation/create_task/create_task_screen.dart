import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/domain/models/task.dart';
import 'package:tasky/injection_container.dart';
import 'package:tasky/presentation/create_task/cubit/create_task_cubit.dart';
import 'package:tasky/utils/constants.dart';
import 'package:tasky/utils/validators.dart';
import 'package:auto_route/auto_route.dart';

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
        title: Text(task != null ? 'Edit' : 'Create'),
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
                      decoration: const InputDecoration(
                        label: Text('Name'),
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
                                children: [
                                  Text(
                                    DateFormat.yMd()
                                        .add_jm()
                                        .format(_pickedDate.value!),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: _pickDateAndTime,
                                      child: const Text('Change Date'),
                                    ),
                                  ),
                                ],
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  _pickedDate.value = DateTime.now()
                                      .add(const Duration(minutes: 1));
                                },
                                child: const Text('Add reminder'),
                              );
                      },
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            task != null
                                ? context.read<CreateTaskCubit>().updateTask(
                                      task!.copyWith(
                                        name: _nameController.text,
                                        date: _pickedDate.value,
                                      ),
                                    )
                                : context.read<CreateTaskCubit>().saveNewTask(
                                      _nameController.text,
                                      _pickedDate.value,
                                    );
                          }
                        },
                        child: const Text('Save'),
                      ),
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
