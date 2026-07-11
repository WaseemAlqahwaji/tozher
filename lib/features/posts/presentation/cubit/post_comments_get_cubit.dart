import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/posts/domain/entity/post_comment.dart';
import 'package:tozher/features/posts/domain/repo/post_repo.dart';

class PostCommentsGetCubit extends Cubit<BaseState<List<PostComment>>> {
  final PostRepo _postRepo;

  PostCommentsGetCubit({required PostRepo postRepo})
    : _postRepo = postRepo,
      super(BaseState());

  void getComments(String postId) async {
    emit(state.setInProgressState());

    final res = await _postRepo.getComments(postId);

    res.fold(
      (fail) => emit(state.setFailureState(fail)),
      (comments) => emit(state.setSuccessState(comments)),
    );
  }
}
