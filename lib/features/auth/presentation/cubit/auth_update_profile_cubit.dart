import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/auth/domain/params/auth_update_profile_params.dart';
import 'package:tozher/features/auth/domain/repo/auth_repo.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';

class AuthUpdateProfileCubit extends Cubit<BaseState<void>> {
  final AuthRepo _authRepo;

  AuthUpdateProfileCubit({required AuthRepo authRepo}) : _authRepo = authRepo, super(BaseState());

  void updateProfile(AuthUpdateProfileParams params) async {
    emit(state.setInProgressState());

    final res = await _authRepo.updateProfile(params);

    res.fold(
      (fail) {
        emit(state.setFailureState(fail));
      },
      (data) {
        emit(state.setSuccessState(null));
      },
    );
  }
}
