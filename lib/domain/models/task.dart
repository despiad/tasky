class Task {
  final int id;
  final String name;
  final DateTime? date;
  final bool isCompleted;

  Task({
    this.id = -1,
    required this.name,
    this.date,
    this.isCompleted = false,
  });

  Task copyWith({int? id, String? name, DateTime? date, bool? isCompleted}) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() {
    return 'Task{id: $id, name: $name, date: $date, isCompleted: $isCompleted}';
  }
}
