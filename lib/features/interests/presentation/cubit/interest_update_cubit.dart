import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/interests/domain/params/interest_update_params.dart';
import 'package:tozher/features/interests/domain/repo/interest_repo.dart';

class InterestUpdateCubit extends Cubit<BaseState> {
  final InterestRepo _interestRepo;

  InterestUpdateCubit({required InterestRepo interestRepo})
      : _interestRepo = interestRepo,
        super(BaseState());

  void updateInterest(InterestUpdateParams params) async {
    emit(state.setInProgressState());

    final res = await _interestRepo.updateInterest(params);

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
