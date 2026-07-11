import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/posts/domain/repo/post_repo.dart';

class ProfileSupportStats {
  final int supportsReceived;
  final int supportingCount;

  const ProfileSupportStats({
    required this.supportsReceived,
    required this.supportingCount,
  });
}

class ProfileSupportStatsCubit extends Cubit<BaseState<ProfileSupportStats>> {
  final PostRepo _postRepo;

  ProfileSupportStatsCubit({required PostRepo postRepo})
    : _postRepo = postRepo,
      super(BaseState());

  void loadStats(String userId) async {
    emit(state.setInProgressState());

    final receivedRes = await _postRepo.getUserSupportsReceived(userId);
    final supportingRes = await _postRepo.getUserSupportingCount(userId);

    final received = receivedRes.fold((_) => 0, (v) => v);
    final supporting = supportingRes.fold((_) => 0, (v) => v);

    emit(state.setSuccessState(ProfileSupportStats(
      supportsReceived: received,
      supportingCount: supporting,
    )));
  }
}
