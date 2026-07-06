import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/auth/domain/repo/auth_repo.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';

class AuthSendPasswordResetCubit extends Cubit<BaseState> {
  final AuthRepo _authRepo;

  AuthSendPasswordResetCubit({required AuthRepo authRepo}) : _authRepo = authRepo, super(BaseState());

  void sendPasswordResetEmail(String email) async {
    emit(state.setInProgressState());

    final res = await _authRepo.sendPasswordResetEmail(email);

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
