// The Task class represents a task with various properties
class Task {
  final int? id; // Unique identifier for the task
  final String? title; // Title of the task
  final String? description; // Description of the task
  final String? notes; // Additional notes for the task
  final DateTime dueDate; // Due date of the task
  final int? color; // Color associated with the task (stored as an integer)
  final bool? notify; // Notification status for the task
  final bool? finished; // Completion status of the task

  // Constructor to initialize the task properties
  Task({
    this.id,
    this.title,
    this.description,
    this.notes,
    required this.dueDate,
    this.color,
    this.notify,
    this.finished,
  });

  // Method to create a copy of the task with updated properties
  Task copyWith({
    int? id,
    String? title,
    String? description,
    String? notes,
    DateTime? dueDate,
    int? color,
    bool? notify,
    bool? finished,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      notes: notes ?? this.notes,
      dueDate: dueDate ?? this.dueDate,
      color: color ?? this.color,
      notify: notify ?? this.notify,
      finished: finished ?? this.finished,
    );
  }

  // Factory constructor to create a Task from a map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      notes: map['notes'],
      dueDate: DateTime.parse(map['dueDate']),
      color: map['color'],
      notify: map['notify'] == 1, // Convert integer to bool
      finished: map['finished'] == 1, // Convert integer to bool
    );
  }

  // Method to convert a Task to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'notes': notes,
      'dueDate': dueDate.toIso8601String(), // Convert DateTime to string
      'color': color,
      'notify': notify == true ? 1 : 0, // Convert bool to integer
      'finished': finished == true ? 1 : 0, // Convert bool to integer
    };
  }
}
