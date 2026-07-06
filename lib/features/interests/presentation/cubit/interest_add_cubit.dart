import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/interests/domain/params/interest_add_params.dart';
import 'package:tozher/features/interests/domain/repo/interest_repo.dart';

class InterestAddCubit extends Cubit<BaseState> {
  final InterestRepo _interestRepo;

  InterestAddCubit({required InterestRepo interestRepo})
      : _interestRepo = interestRepo,
        super(BaseState());

  void addInterest(InterestAddParams params) async {
    emit(state.setInProgressState());

    final res = await _interestRepo.addInterest(params);

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
