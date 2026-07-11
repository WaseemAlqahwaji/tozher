import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tozher/features/posts/domain/params/post_add_params.dart';

class PostAddModel {
  final String userId;
  final String userFullName;
  final String title;
  final List<String> photos;
  final int likeCount;
  final int commentCount;
  final int supportCount;
  final int shareCount;
  final String? interestId;
  final DateTime createdAt;

  PostAddModel({
    required this.userId,
    required this.userFullName,
    required this.title,
    required this.photos,
    required this.likeCount,
    this.commentCount = 0,
    this.supportCount = 0,
    this.shareCount = 0,
    this.interestId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'user_full_name': userFullName,
      'title': title,
      'photos': photos,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'supportCount': supportCount,
      'shareCount': shareCount,
      'interestId': interestId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}

extension PostAddParamsToModel on PostAddParams {
  PostAddModel toModel() {
    return PostAddModel(
      userId: userId,
      userFullName: userFullName,
      title: title,
      photos: photos,
      likeCount: likeCount,
      interestId: interest?.id,
    );
  }
}
