import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tozher/features/image_upload/domain/entity/uploaded_image.dart';

class ImageUploadSource {
  static const String _baseUrl = 'https://api.imgbb.com/1/upload';
  static const String _apiKey =
      '762ae6248d0ae3344c6d7783f41cd785'; // TODO: replace with real key

  final Dio _dio;

  ImageUploadSource(this._dio);

  Future<UploadedImage> uploadImage(File imageFile) async {
    final formData = FormData.fromMap({
      'key': _apiKey,
      'image': await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
      ),
    });

    final response = await _dio.post(_baseUrl, data: formData);

    final data = response.data['data'] as Map<String, dynamic>;
    return UploadedImage.fromJson(data);
  }

  Future<List<UploadedImage>> uploadImages(List<File> imageFiles) async {
    final results = <UploadedImage>[];
    for (final file in imageFiles) {
      results.add(await uploadImage(file));
    }
    return results;
  }
}
