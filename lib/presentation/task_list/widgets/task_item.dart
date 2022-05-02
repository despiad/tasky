import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:tasky/domain/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function(BuildContext) onDelete;
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
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            label: 'Delete',
            backgroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: onDelete,
          ),
        ],
      ),
      child: ListTile(
        title: Text(task.name),
        subtitle: task.date != null
            ? Text(DateFormat.yMMMd().add_Hm().format(task.date!))
            : null,
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
