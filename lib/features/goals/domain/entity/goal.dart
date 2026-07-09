import 'package:tozher/features/goals/domain/entity/achievement.dart';

class Goal {
  final String id;
  final String userId;
  final String name;
  final String description;
  final DateTime date;
  final DateTime reminderDate;
  final String status;
  final DateTime createdAt;
  final bool isPrivate;
  final List<Achievement> achievements;

  const Goal({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.date,
    required this.reminderDate,
    required this.status,
    required this.createdAt,
    required this.isPrivate,
    this.achievements = const [],
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
    bool? isPrivate,
    List<Achievement>? achievements,
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
      isPrivate: isPrivate ?? this.isPrivate,
      achievements: achievements ?? this.achievements,
    );
  }
}
