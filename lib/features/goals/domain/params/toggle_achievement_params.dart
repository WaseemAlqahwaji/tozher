class ToggleAchievementParams {
  final String userId;
  final String goalId;
  final String achievementId;
  final bool isDone;

  ToggleAchievementParams({
    required this.userId,
    required this.goalId,
    required this.achievementId,
    required this.isDone,
  });
}
