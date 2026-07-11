import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/posts/domain/entity/post.dart';
import 'package:tozher/features/posts/domain/repo/post_repo.dart';

class PostUserGetCubit extends Cubit<BaseState<List<Post>>> {
  final PostRepo _postRepo;

  PostUserGetCubit({required PostRepo postRepo})
    : _postRepo = postRepo,
      super(BaseState());

  void getPostsByUserId(String userId) async {
    emit(state.setInProgressState());

    final res = await _postRepo.getPostsByUserId(userId);

    res.fold(
      (fail) => emit(state.setFailureState(fail)),
      (posts) => emit(state.setSuccessState(posts)),
    );
  }
}
