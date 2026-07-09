import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/goals/domain/entity/goal.dart';
import 'package:tozher/features/goals/domain/repo/goal_repo.dart';

class GoalGetCubit extends Cubit<BaseState<List<Goal>>> {
  final GoalRepo _goalRepo;

  GoalGetCubit({required GoalRepo goalRepo})
      : _goalRepo = goalRepo,
        super(BaseState());

  void getGoals(String userId) async {
    emit(state.setInProgressState());

    final res = await _goalRepo.getGoals(userId);

    res.fold(
      (fail) {
        emit(state.setFailureState(fail));
      },
      (data) {
        emit(state.setSuccessState(data));
      },
    );
  }
}
