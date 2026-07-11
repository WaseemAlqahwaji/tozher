import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/auth/domain/repo/auth_repo.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';

class AuthLogoutCubit extends Cubit<BaseState> {
  final AuthRepo authRepo;

  AuthLogoutCubit({required this.authRepo}) : super(BaseState());

  void logout() async {
    emit(state.setInProgressState());

    final res = await authRepo.logout();

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
