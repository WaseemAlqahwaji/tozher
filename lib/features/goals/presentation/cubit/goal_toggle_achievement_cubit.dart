import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/goals/domain/params/toggle_achievement_params.dart';
import 'package:tozher/features/goals/domain/repo/goal_repo.dart';

class GoalToggleAchievementCubit extends Cubit<BaseState> {
  final GoalRepo _goalRepo;

  GoalToggleAchievementCubit({required GoalRepo goalRepo})
      : _goalRepo = goalRepo,
        super(BaseState());

  void toggleAchievement(ToggleAchievementParams params) async {
    emit(state.setInProgressState());

    final res = await _goalRepo.toggleAchievement(params);

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
