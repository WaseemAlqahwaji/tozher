import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tozher/features/goals/domain/entity/achievement.dart';

class Goal {
  final String id;
  final String userId;
  final String name;
  final String description;
  final Timestamp date;
  final Timestamp reminderDate;
  final String status;
  final Timestamp createdAt;
  final bool isPrivate;

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
  });

  Goal copyWith({
    String? id,
    String? userId,
    String? name,
    String? description,
    Timestamp? date,
    Timestamp? reminderDate,
    String? status,
    Timestamp? createdAt,
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
    );
  }
}
