import 'package:tozher/features/goals/data/model/achievement_model.dart';
import 'package:tozher/features/goals/domain/entity/goal.dart';

class GoalModel {
  final String id;
  final String userId;
  final String name;
  final String description;
  final DateTime date;
  final DateTime reminderDate;
  final DateTime createdAt;
  final String status;
  final bool isPrivate;
  final List<AchievementModel> achievements;

  const GoalModel({
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

  Goal toEntity() => Goal(
    id: id,
    userId: userId,
    name: name,
    description: description,
    date: date,
    reminderDate: reminderDate,
    status: status,
    createdAt: createdAt,
    isPrivate: isPrivate,
    achievements: achievements.map((a) => a.toEntity()).toList(),
  );

  factory GoalModel.fromEntity(Goal entity) => GoalModel(
    id: entity.id,
    userId: entity.userId,
    name: entity.name,
    description: entity.description,
    date: entity.date,
    reminderDate: entity.reminderDate,
    status: entity.status,
    createdAt: entity.createdAt,
    isPrivate: entity.isPrivate,
    achievements: entity.achievements
        .map((a) => AchievementModel.fromEntity(a))
        .toList(),
  );

  factory GoalModel.fromMap(Map<String, dynamic> map, String documentId) {
    return GoalModel(
      id: documentId,
      userId: map['user_id'] as String,
      name: map['name'] as String,
      description: map['description'] as String? ?? '',
      date: map['date'],
      reminderDate: map['reminder_date'],
      status: map['status'] as String? ?? 'private',
      createdAt: map['created_at'],
      isPrivate: map['is_private'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'description': description,
      'date': date,
      'reminder_date': reminderDate,
      'status': status,
      'created_at': createdAt,
      'is_private': isPrivate,
    };
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is DateTime) return value;
    return DateTime.parse(value as String);
  }
}

extension GoalEntityToModel on Goal {
  GoalModel toModel() => GoalModel.fromEntity(this);
}
