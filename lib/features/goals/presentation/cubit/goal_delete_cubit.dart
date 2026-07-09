import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/goals/domain/params/goal_delete_params.dart';
import 'package:tozher/features/goals/domain/repo/goal_repo.dart';

class GoalDeleteCubit extends Cubit<BaseState> {
  final GoalRepo _goalRepo;

  GoalDeleteCubit({required GoalRepo goalRepo})
      : _goalRepo = goalRepo,
        super(BaseState());

  void deleteGoal(GoalDeleteParams params) async {
    emit(state.setInProgressState());

    final res = await _goalRepo.deleteGoal(params);

    res.fold(
      (fail) {
        emit(state.setFailureState(fail));
      },
      (_) {
        emit(state.setSuccessState(null));
      },
    );
  }
}
