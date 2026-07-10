import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/posts/domain/params/post_add_params.dart';
import 'package:tozher/features/posts/domain/repo/post_repo.dart';

class PostAddCubit extends Cubit<BaseState> {
  final PostRepo _postRepo;

  PostAddCubit({required PostRepo postRepo})
    : _postRepo = postRepo,
      super(BaseState());

  void addPost(PostAddParams params) async {
    emit(state.setInProgressState());

    final res = await _postRepo.addPost(params);

    res.fold(
      (fail) => emit(state.setFailureState(fail)),
      (_) => emit(state.setSuccessState(null)),
    );
  }
}
