import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/goals/domain/params/goal_add_params.dart';
import 'package:tozher/features/goals/domain/repo/goal_repo.dart';

class GoalAddCubit extends Cubit<BaseState> {
  final GoalRepo _goalRepo;

  GoalAddCubit({required GoalRepo goalRepo})
      : _goalRepo = goalRepo,
        super(BaseState());

  void addGoal(GoalAddParams params) async {
    emit(state.setInProgressState());

    final res = await _goalRepo.addGoal(params);

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
