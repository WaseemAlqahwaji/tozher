import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/posts/domain/params/post_comment_add_params.dart';
import 'package:tozher/features/posts/domain/repo/post_repo.dart';

class PostCommentAddCubit extends Cubit<BaseState> {
  final PostRepo _postRepo;

  PostCommentAddCubit({required PostRepo postRepo})
      : _postRepo = postRepo,
        super(BaseState());

  void addComment(PostCommentAddParams params) async {
    emit(state.setInProgressState());
    final res = await _postRepo.addComment(params);
    res.fold(
      (fail) => emit(state.setFailureState(fail)),
      (_) => emit(state.setSuccessState(null)),
    );
  }
}
