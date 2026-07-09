class GoalUpdateParams {
  final String id;
  final String name;
  final String description;
  final DateTime date;
  final DateTime reminderDate;
  final String status;
  final bool isPrivate;

  GoalUpdateParams({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.reminderDate,
    required this.status,
    required this.isPrivate,
  });
}
