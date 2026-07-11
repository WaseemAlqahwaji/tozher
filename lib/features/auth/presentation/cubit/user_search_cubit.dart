import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/auth/data/model/user_model.dart';
import 'package:tozher/features/auth/domain/repo/auth_repo.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';

class UserSearchCubit extends Cubit<BaseState<List<UserModel>>> {
  final AuthRepo _authRepo;

  UserSearchCubit({required AuthRepo authRepo})
    : _authRepo = authRepo,
      super(BaseState());

  void search(String query) async {
    if (query.trim().isEmpty) {
      emit(state.setSuccessState([]));
      return;
    }

    emit(state.setInProgressState());

    final res = await _authRepo.searchUsers(query.trim());

    res.fold(
      (fail) => emit(state.setFailureState(fail)),
      (users) => emit(state.setSuccessState(users)),
    );
  }
}
