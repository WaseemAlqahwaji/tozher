import 'package:tozher/features/goals/domain/params/goal_add_params.dart';

class GoalAddModel {
  final String userId;
  final String name;
  final String description;
  final DateTime date;
  final DateTime reminderDate;
  final String status;
  final bool isPrivate;
  final List<String> achievementsNames;

  GoalAddModel({
    required this.userId,
    required this.name,
    required this.description,
    required this.date,
    required this.reminderDate,
    required this.status,
    required this.isPrivate,
    required this.achievementsNames,
  });
}

extension GoalAddModelExtension on GoalAddModel {
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'name': name,
      'description': description,
      'date': date,
      'reminder_date': reminderDate,
      'status': status,
      'is_private': isPrivate,
    };
  }
}

extension GoalAddParamsExtension on GoalAddParams {
  GoalAddModel toModel() {
    return GoalAddModel(
      userId: userId,
      name: name,
      description: description,
      date: date,
      reminderDate: reminderDate,
      status: status,
      isPrivate: isPrivate,
      achievementsNames: achievementAddParams.names,
    );
  }
}
