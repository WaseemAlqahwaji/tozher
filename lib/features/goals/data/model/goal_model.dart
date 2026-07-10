import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tozher/features/goals/data/model/achievement_model.dart';
import 'package:tozher/features/goals/domain/entity/goal.dart';

class GoalModel {
  final String id;
  final String userId;
  final String name;
  final String description;
  final Timestamp date;
  final Timestamp reminderDate;
  final Timestamp createdAt;
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
  );


  factory GoalModel.fromMap(
    Map<String, dynamic> map,
    String documentId,
    List<AchievementModel> achievements,
  ) {
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
      achievements: achievements,
    );
  }
}
