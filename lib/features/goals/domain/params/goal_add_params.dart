class GoalAddParams {
  final String userId;
  final String name;
  final String description;
  final DateTime date;
  final DateTime reminderDate;
  final String status;
  final bool isPrivate;

  GoalAddParams({
    required this.userId,
    required this.name,
    required this.description,
    required this.date,
    required this.reminderDate,
    required this.status,
    required this.isPrivate,
  });
}
