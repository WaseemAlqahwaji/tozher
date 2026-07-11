import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/auth/presentation/cubit/auth_login_cubit.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/posts/domain/entity/post.dart';
import 'package:tozher/features/posts/domain/repo/post_repo.dart';
import 'package:tozher/injection.dart';

class PostGetCubit extends Cubit<BaseState<List<Post>>> {
  final PostRepo _postRepo;

  PostGetCubit({required PostRepo postRepo})
    : _postRepo = postRepo,
      super(BaseState());

  void getPosts() async {
    emit(state.setInProgressState());

    final currentUserId = getIt<AuthLoginCubit>().state.item?.uid;
    final res = await _postRepo.getPosts(currentUserId: currentUserId);

    res.fold(
      (fail) => emit(state.setFailureState(fail)),
      (posts) => emit(state.setSuccessState(posts)),
    );
  }
}
