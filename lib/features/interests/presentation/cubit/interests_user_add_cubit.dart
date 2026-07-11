import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/interests/domain/params/interests_user_add_params.dart';
import 'package:tozher/features/interests/domain/repo/interest_repo.dart';

class InterestsUserAddCubit extends Cubit<BaseState> {
  final InterestRepo _interestRepo;

  InterestsUserAddCubit({required InterestRepo interestRepo})
    : _interestRepo = interestRepo,
      super(BaseState());

  void addUserInterests(InterestsUserAddParams params) async {
    emit(state.setInProgressState());

    final res = await _interestRepo.addUserInterests(params);

    res.fold(
      (fail) => emit(state.setFailureState(fail)),
      (_) => emit(state.setSuccessState(null)),
    );
  }
}
