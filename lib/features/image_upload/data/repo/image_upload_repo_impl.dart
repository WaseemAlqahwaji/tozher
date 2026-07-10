import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:tozher/features/core/domain/entity/failure.dart';
import 'package:tozher/features/core/error/error_converter.dart';
import 'package:tozher/features/image_upload/data/source/image_upload_source.dart';
import 'package:tozher/features/image_upload/domain/entity/uploaded_image.dart';
import 'package:tozher/features/image_upload/domain/repo/image_upload_repo.dart';

class ImageUploadRepoImpl extends ImageUploadRepo {
  final ImageUploadSource _source;

  ImageUploadRepoImpl(this._source);

  @override
  Future<Either<Failure, UploadedImage>> uploadImage(String filePath) async {
    return ErrorConverter.safeCall<UploadedImage>(() async {
      return await _source.uploadImage(File(filePath));
    });
  }

  @override
  Future<Either<Failure, List<UploadedImage>>> uploadImages(
    List<String> filePaths,
  ) async {
    return ErrorConverter.safeCall<List<UploadedImage>>(() async {
      final files = filePaths.map((path) => File(path)).toList();
      return await _source.uploadImages(files);
    });
  }
}
