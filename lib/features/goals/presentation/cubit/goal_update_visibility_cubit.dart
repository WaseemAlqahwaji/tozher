import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/goals/domain/params/update_goal_visibility_params.dart';
import 'package:tozher/features/goals/domain/repo/goal_repo.dart';

class GoalUpdateVisibilityCubit extends Cubit<BaseState> {
  final GoalRepo _goalRepo;

  GoalUpdateVisibilityCubit({required GoalRepo goalRepo})
      : _goalRepo = goalRepo,
        super(BaseState());

  void updateGoalVisibility(UpdateGoalVisibilityParams params) async {
    emit(state.setInProgressState());

    final res = await _goalRepo.updateGoalVisibility(params);

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
