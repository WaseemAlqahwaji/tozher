import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/auth/domain/repo/auth_repo.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';

class AuthRegisterCubit extends Cubit<BaseState<User?>> {
  final AuthRepo _authRepo;

  AuthRegisterCubit({required AuthRepo authRepo}) : _authRepo = authRepo, super(BaseState());

  void register(String email, String password) async {
    emit(state.setInProgressState());
    final res = await _authRepo.register(email, password);

    res.fold(
      (fail) {
        emit(state.setFailureState(fail));
      },
      (data) {
        emit(state.setSuccessState(data.user));
      },
    );
  }
}
