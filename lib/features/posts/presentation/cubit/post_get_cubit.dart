import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/posts/domain/entity/post.dart';
import 'package:tozher/features/posts/domain/repo/post_repo.dart';

class PostGetCubit extends Cubit<BaseState<List<Post>>> {
  final PostRepo _postRepo;

  PostGetCubit({required PostRepo postRepo})
    : _postRepo = postRepo,
      super(BaseState());

  void getPosts() async {
    emit(state.setInProgressState());

    final res = await _postRepo.getPosts();

    res.fold(
      (fail) => emit(state.setFailureState(fail)),
      (posts) => emit(state.setSuccessState(posts)),
    );
  }
}
