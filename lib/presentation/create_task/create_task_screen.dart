import 'dart:ui';

import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tasky/domain/models/task.dart';
import 'package:tasky/utils/constants.dart';
import 'package:tasky/utils/validators.dart';

class CreateTaskScreen extends StatefulWidget {
  final Task? task;
  final int? taskId;

  const CreateTaskScreen({@PathParam() this.taskId, this.task, Key? key})
      : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<DateTime> _pickedDate =
      ValueNotifier<DateTime>(DateTime.now());
  late TextEditingController _nameController;

  Task? get task => widget.task;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: task?.name ?? '');
    _pickedDate.value = task?.date ?? DateTime.now();
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
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
              Row(
                children: [
                  Text(
                    DateFormat.yMd().add_jm().format(_pickedDate.value),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: _pickedDate.value,
                          firstDate: _pickedDate.value,
                          lastDate: DateTime(2050),
                        );
                        if (date == null) {
                          return;
                        }
                        final TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime:
                              TimeOfDay.fromDateTime(_pickedDate.value),
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
                      },
                      child: const Text('Change Date'),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
