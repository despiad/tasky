import 'package:tasky/infrastructure/database/database.dart';

class Task {
  final int id;
  final String name;
  final DateTime? date;
  final bool isCompleted;

  Task({
    required this.id,
    required this.name,
    required this.date,
    required this.isCompleted,
  });
}
