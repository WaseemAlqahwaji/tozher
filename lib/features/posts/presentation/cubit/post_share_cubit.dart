import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/posts/domain/params/post_share_params.dart';
import 'package:tozher/features/posts/domain/repo/post_repo.dart';

class PostShareCubit extends Cubit<BaseState> {
  final PostRepo _postRepo;

  PostShareCubit({required PostRepo postRepo})
      : _postRepo = postRepo,
        super(BaseState());

  void sharePost(PostShareParams params) async {
    emit(state.setInProgressState());
    final res = await _postRepo.sharePost(params);
    res.fold(
      (fail) => emit(state.setFailureState(fail)),
      (_) => emit(state.setSuccessState(null)),
    );
  }
}
