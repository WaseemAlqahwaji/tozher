import 'package:dartz/dartz.dart';
import 'package:tozher/features/core/domain/entity/failure.dart';
import 'package:tozher/features/goals/domain/entity/goal.dart';
import 'package:tozher/features/goals/domain/params/goal_add_params.dart';
import 'package:tozher/features/goals/domain/params/goal_delete_params.dart';
import 'package:tozher/features/goals/domain/params/goal_update_params.dart';
import 'package:tozher/features/goals/domain/params/toggle_achievement_params.dart';
import 'package:tozher/features/goals/domain/params/update_goal_visibility_params.dart';

abstract class GoalRepo {
  Future<Either<Failure, List<Goal>>> getGoals(String userId);

  Future<Either<Failure, void>> addGoal(GoalAddParams params);
  Future<Either<Failure, void>> updateGoal(GoalUpdateParams params);
  Future<Either<Failure, void>> deleteGoal(GoalDeleteParams params);

  Future<Either<Failure, void>> updateGoalVisibility(
    UpdateGoalVisibilityParams params,
  );
  Future<Either<Failure, void>> toggleAchievement(
    ToggleAchievementParams params,
  );
}
