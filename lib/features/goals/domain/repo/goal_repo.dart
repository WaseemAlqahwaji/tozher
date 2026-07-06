import 'package:dartz/dartz.dart';
import 'package:tozher/features/core/domain/entity/failure.dart';
import 'package:tozher/features/goals/domain/entity/goal.dart';

abstract class GoalRepo {
  Future<Either<Failure, List<Goal>>> getGoals();

  Future<Either<Failure, void>> addGoal(Goal goal);
  Future<Either<Failure, void>> updateGoal(Goal goal);
  Future<Either<Failure, void>> deleteGoal(String goalId);
}
