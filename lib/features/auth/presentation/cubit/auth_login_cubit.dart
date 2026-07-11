import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/auth/data/model/user_model.dart';
import 'package:tozher/features/auth/domain/repo/auth_repo.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';

class AuthLoginCubit extends Cubit<BaseState<UserModel>> {
  final AuthRepo _authRepo;

  AuthLoginCubit({required AuthRepo authRepo}) : _authRepo = authRepo, super(BaseState());

  void login(String email, String password) async {
    emit(state.setInProgressState());

    final res = await _authRepo.login(email, password);

    res.fold(
      (fail) {
        emit(state.setFailureState(fail));
      },
      (data) {
        emit(state.setSuccessState(data));
      },
    );
  }

  /// Re-fetches the user profile from Firestore and updates the state.
  /// Call this after external mutations (e.g. points change via achievement toggle).
  void refreshUser(String uid) async {
    final res = await _authRepo.getProfile(uid);
    res.fold(
      (_) {}, // Keep existing state on failure
      (user) => emit(state.setSuccessState(user)),
    );
  }
}
