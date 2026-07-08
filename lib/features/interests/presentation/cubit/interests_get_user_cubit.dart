import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/interests/domain/entity/interest.dart';
import 'package:tozher/features/interests/domain/repo/interest_repo.dart';

class InterestsGetUserCubit extends Cubit<BaseState<List<Interest>>> {
  final InterestRepo _interestRepo;

  InterestsGetUserCubit({required InterestRepo interestRepo})
      : _interestRepo = interestRepo,
        super(BaseState());

  void getInterests(String uid) async {
    emit(state.setInProgressState());

    final res = await _interestRepo.getUserInterests(uid);

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
