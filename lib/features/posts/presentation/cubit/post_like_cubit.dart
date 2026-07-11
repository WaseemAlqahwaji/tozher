import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/posts/domain/params/post_like_params.dart';
import 'package:tozher/features/posts/domain/repo/post_repo.dart';

class PostLikeCubit extends Cubit<BaseState> {
  final PostRepo _postRepo;

  PostLikeCubit({required PostRepo postRepo})
      : _postRepo = postRepo,
        super(BaseState());

  void likePost(PostLikeParams params) async {
    emit(state.setInProgressState());
    final res = await _postRepo.likePost(params);
    res.fold(
      (fail) => emit(state.setFailureState(fail)),
      (_) => emit(state.setSuccessState(null)),
    );
  }

  void unlikePost(PostLikeParams params) async {
    emit(state.setInProgressState());
    final res = await _postRepo.unlikePost(params);
    res.fold(
      (fail) => emit(state.setFailureState(fail)),
      (_) => emit(state.setSuccessState(null)),
    );
  }
}
