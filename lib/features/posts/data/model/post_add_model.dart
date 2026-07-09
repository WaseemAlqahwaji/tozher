import 'package:tozher/features/posts/domain/params/post_add_params.dart';

class PostAddModel {
  final String title;
  final List<String> photos;
  final int likeCount;
  final int commentCount;
  final int supportCount;
  final int shareCount;
  final List<String> interestsIds;
  DateTime createdAt;

  PostAddModel({
    required this.title,
    required this.photos,
    required this.likeCount,
    this.commentCount = 0,
    this.supportCount = 0,
    this.shareCount = 0,
    required this.interestsIds,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory PostAddModel.fromEntity(PostAddParams params) {
    return PostAddModel(
      title: params.title,
      photos: params.photos,
      likeCount: params.likeCount,
      interestsIds: params.interests.map((interest) => interest.name).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'photos': photos,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'supportCount': supportCount,
      'shareCount': shareCount,
      'interestsIds': interestsIds,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
