import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tasky/domain/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onLongPress;
  final VoidCallback onTap;
  final Function(bool?) onCheckboxChanged;

  const TaskItem({
    Key? key,
    required this.task,
    required this.onDelete,
    required this.onCheckboxChanged,
    required this.onLongPress,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: key,
      actionPane: const SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: onDelete,
        ),
      ],
      child: ListTile(
        title: Text(task.name),
        subtitle: task.date != null ? Text(task.date.toString()) : null,
        trailing: Checkbox(
          onChanged: onCheckboxChanged,
          value: task.isCompleted,
        ),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}
