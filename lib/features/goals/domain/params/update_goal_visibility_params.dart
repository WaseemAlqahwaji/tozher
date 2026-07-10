class UpdateGoalVisibilityParams {
  final String userId;
  final String goalId;
  final bool isPrivate;

  UpdateGoalVisibilityParams({
    required this.userId,
    required this.goalId,
    required this.isPrivate,
  });
}
