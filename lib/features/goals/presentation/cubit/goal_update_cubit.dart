import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/goals/domain/params/goal_update_params.dart';
import 'package:tozher/features/goals/domain/repo/goal_repo.dart';

class GoalUpdateCubit extends Cubit<BaseState> {
  final GoalRepo _goalRepo;

  GoalUpdateCubit({required GoalRepo goalRepo})
      : _goalRepo = goalRepo,
        super(BaseState());

  void updateGoal(GoalUpdateParams params) async {
    emit(state.setInProgressState());

    final res = await _goalRepo.updateGoal(params);

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
