import 'package:tozher/features/interests/domain/entity/interest.dart';

class PostAddParams {
  final String userId;
  final String userFullName;
  final String title;
  final List<String> photos;
  final int likeCount;
  final Interest? interest;

  PostAddParams({
    required this.userId,
    required this.userFullName,
    required this.title,
    required this.photos,
    required this.likeCount,
    this.interest,
  });
}
