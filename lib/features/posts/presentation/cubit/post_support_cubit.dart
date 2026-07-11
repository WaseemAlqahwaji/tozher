import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/posts/domain/params/post_support_params.dart';
import 'package:tozher/features/posts/domain/repo/post_repo.dart';

class PostSupportCubit extends Cubit<BaseState> {
  final PostRepo _postRepo;

  PostSupportCubit({required PostRepo postRepo})
      : _postRepo = postRepo,
        super(BaseState());

  void supportPost(PostSupportParams params) async {
    emit(state.setInProgressState());
    final res = await _postRepo.supportPost(params);
    res.fold(
      (fail) => emit(state.setFailureState(fail)),
      (_) => emit(state.setSuccessState(null)),
    );
  }
}
