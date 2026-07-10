import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/image_upload/domain/entity/uploaded_image.dart';
import 'package:tozher/features/image_upload/domain/repo/image_upload_repo.dart';

class ImageUploadCubit extends Cubit<BaseState<List<UploadedImage>>> {
  final ImageUploadRepo _repo;

  ImageUploadCubit({required ImageUploadRepo repo})
    : _repo = repo,
      super(BaseState());

  void uploadImages(List<String> filePaths) async {
    emit(state.setInProgressState());

    final res = await _repo.uploadImages(filePaths);

    res.fold(
      (fail) => emit(state.setFailureState(fail)),
      (images) => emit(state.setSuccessState(images)),
    );
  }
}
