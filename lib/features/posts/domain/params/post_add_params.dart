import 'package:tozher/features/interests/domain/entity/interest.dart';

class PostAddParams {
  final String title;
  final List<String> photos;
  final int likeCount;
  final List<Interest> interests;

  PostAddParams({
    required this.title,
    required this.photos,
    required this.likeCount,
    required this.interests,
  });
}
