import 'package:json_annotation/json_annotation.dart';
import 'package:tozher/features/goals/domain/entity/goal.dart';

class GoalModel {
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  final String name;
  final String description;
  final DateTime date;
  @JsonKey(name: 'reminder_date')
  final DateTime reminderDate;
  final String status;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  const GoalModel({
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

  Goal toEntity() => Goal(
    id: id,
    userId: userId,
    name: name,
    description: description,
    date: date,
    reminderDate: reminderDate,
    status: status,
    createdAt: createdAt,
    updatedAt: updatedAt,
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
        updatedAt: entity.updatedAt,
      );

  factory GoalModel.fromMap(Map<String, dynamic> map) {
    return GoalModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      name: map['name'] as String,
      description: map['description'] as String? ?? '',
      date: _parseDateTime(map['date']),
      reminderDate: _parseDateTime(map['reminder_date']),
      status: map['status'] as String? ?? 'private',
      createdAt: map['created_at'] != null
          ? _parseDateTime(map['created_at'])
          : null,
      updatedAt: map['updated_at'] != null
          ? _parseDateTime(map['updated_at'])
          : null,
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
      'updated_at': updatedAt,
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
