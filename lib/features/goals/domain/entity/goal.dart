class Goal {
  final String id;
  final String userId;
  final String name;
  final String description;
  final DateTime date;
  final DateTime reminderDate;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Goal({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.date,
    required this.reminderDate,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  Goal copyWith({
    String? id,
    String? userId,
    String? name,
    String? description,
    DateTime? date,
    DateTime? reminderDate,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Goal(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      date: date ?? this.date,
      reminderDate: reminderDate ?? this.reminderDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
