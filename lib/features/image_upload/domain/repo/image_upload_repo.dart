import 'package:dartz/dartz.dart';
import 'package:tozher/features/core/domain/entity/failure.dart';
import 'package:tozher/features/image_upload/domain/entity/uploaded_image.dart';

abstract class ImageUploadRepo {
  Future<Either<Failure, UploadedImage>> uploadImage(String filePath);
  Future<Either<Failure, List<UploadedImage>>> uploadImages(
    List<String> filePaths,
  );
}
