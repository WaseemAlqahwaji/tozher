import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/interests/domain/repo/interest_repo.dart';

class InterestDeleteCubit extends Cubit<BaseState> {
  final InterestRepo _interestRepo;

  InterestDeleteCubit({required InterestRepo interestRepo})
      : _interestRepo = interestRepo,
        super(BaseState());

  void deleteInterest(String interestId) async {
    emit(state.setInProgressState());

    final res = await _interestRepo.deleteInterest(interestId);

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
