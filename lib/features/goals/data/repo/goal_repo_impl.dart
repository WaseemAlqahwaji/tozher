import 'package:dartz/dartz.dart';
import 'package:tozher/features/core/domain/entity/failure.dart';
import 'package:tozher/features/core/error/error_converter.dart';
import 'package:tozher/features/goals/data/model/goal_model.dart';
import 'package:tozher/features/goals/data/source/goal_source.dart';
import 'package:tozher/features/goals/domain/entity/goal.dart';
import 'package:tozher/features/goals/domain/repo/goal_repo.dart';

class GoalRepoImpl extends GoalRepo {
  final GoalSource goalSource;

  GoalRepoImpl(this.goalSource);

  @override
  Future<Either<Failure, List<Goal>>> getGoals() async {
    return ErrorConverter.safeCall<List<Goal>>(() async {
      final goalModels = await goalSource.getGoals();
      return goalModels.map((goalModel) => goalModel.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, void>> addGoal(Goal goal) async {
    return ErrorConverter.safeCall<void>(() async {
      final goalModel = GoalModel.fromEntity(goal);
      await goalSource.addGoal(goalModel);
    });
  }

  @override
  Future<Either<Failure, void>> updateGoal(Goal goal) async {
    return ErrorConverter.safeCall<void>(() async {
      final goalModel = GoalModel.fromEntity(goal);
      await goalSource.updateGoal(goalModel);
    });
  }

  @override
  Future<Either<Failure, void>> deleteGoal(String goalId) async {
    return ErrorConverter.safeCall<void>(() async {
      await goalSource.deleteGoal(goalId);
    });
  }
}
