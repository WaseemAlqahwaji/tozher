class ToggleAchievementParams {
  final String goalId;
  final String achievementId;
  final bool isDone;

  ToggleAchievementParams({
    required this.goalId,
    required this.achievementId,
    required this.isDone,
  });
}
