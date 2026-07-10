import 'package:tozher/features/goals/domain/params/achievement_add_params.dart';

class GoalAddParams {
  final String userId;
  final String name;
  final String description;
  final DateTime date;
  final DateTime reminderDate;
  final String status;
  final bool isPrivate;
  final AchievementAddParams achievementAddParams;
  final DateTime createdAt;

  GoalAddParams({
    required this.userId,
    required this.name,
    required this.description,
    required this.date,
    required this.reminderDate,
    required this.status,
    required this.isPrivate,
    required this.achievementAddParams,
    required this.createdAt,
  });
}
