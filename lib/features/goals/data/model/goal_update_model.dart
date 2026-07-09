import 'package:tozher/features/goals/domain/params/goal_update_params.dart';

class GoalUpdateModel {
  final String name;
  final String description;
  final DateTime date;
  final DateTime reminderDate;
  final String status;
  final bool isPrivate;

  GoalUpdateModel({
    required this.name,
    required this.description,
    required this.date,
    required this.reminderDate,
    required this.status,
    required this.isPrivate,
  });
}

extension GoalUpdateModelExtension on GoalUpdateModel {
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'date': date,
      'reminder_date': reminderDate,
      'status': status,
      'is_private': isPrivate,
    };
  }
}

extension GoalUpdateParamsExtension on GoalUpdateParams {
  GoalUpdateModel toModel() {
    return GoalUpdateModel(
      name: name,
      description: description,
      date: date,
      reminderDate: reminderDate,
      status: status,
      isPrivate: isPrivate,
    );
  }
}
