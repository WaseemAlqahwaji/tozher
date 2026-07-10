import 'package:dartz/dartz.dart';
import 'package:tozher/features/core/domain/entity/failure.dart';
import 'package:tozher/features/core/error/error_converter.dart';
import 'package:tozher/features/goals/data/model/goal_add_model.dart';
import 'package:tozher/features/goals/data/model/goal_update_model.dart';
import 'package:tozher/features/goals/data/source/goal_source.dart';
import 'package:tozher/features/goals/domain/entity/goal.dart';
import 'package:tozher/features/goals/domain/params/goal_add_params.dart';
import 'package:tozher/features/goals/domain/params/goal_delete_params.dart';
import 'package:tozher/features/goals/domain/params/goal_update_params.dart';
import 'package:tozher/features/goals/domain/params/toggle_achievement_params.dart';
import 'package:tozher/features/goals/domain/params/update_goal_visibility_params.dart';
import 'package:tozher/features/goals/domain/repo/goal_repo.dart';

class GoalRepoImpl extends GoalRepo {
  final GoalSource goalSource;

  GoalRepoImpl(this.goalSource);

  @override
  Future<Either<Failure, List<Goal>>> getGoals(String userId) async {
    return ErrorConverter.safeCall<List<Goal>>(() async {
      final goalModels = await goalSource.getGoals(userId);
      return goalModels.map((goalModel) => goalModel.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, void>> addGoal(GoalAddParams params) async {
    return ErrorConverter.safeCall<void>(() async {
      final model = params.toModel();
      await goalSource.addGoal(model);
    });
  }

  @override
  Future<Either<Failure, void>> updateGoal(GoalUpdateParams params) async {
    return ErrorConverter.safeCall<void>(() async {
      await goalSource.updateGoal(params.id, params.toModel());
    });
  }

  @override
  Future<Either<Failure, void>> deleteGoal(GoalDeleteParams params) async {
    return ErrorConverter.safeCall<void>(() async {
      await goalSource.deleteGoal(params.goalId);
    });
  }

  @override
  Future<Either<Failure, void>> updateGoalVisibility(
    UpdateGoalVisibilityParams params,
  ) async {
    return ErrorConverter.safeCall<void>(() async {
      await goalSource.updateGoalVisibility(params.goalId, params.isPrivate);
    });
  }

  @override
  Future<Either<Failure, void>> toggleAchievement(
    ToggleAchievementParams params,
  ) async {
    return ErrorConverter.safeCall<void>(() async {
      await goalSource.toggleAchievement(
        params.goalId,
        params.achievementId,
        params.isDone,
      );
    });
  }
}
