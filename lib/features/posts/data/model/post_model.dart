import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tozher/features/posts/domain/entity/post.dart';

class PostModel {
  final String id;
  final String userId;
  final String userFullName;
  final String title;
  final List<String> photos;
  final int likeCount;
  final int commentCount;
  final int supportCount;
  final int shareCount;
  final DateTime createdAt;
  final String? interestId;
  final String? interestName;

  PostModel({
    required this.id,
    required this.userId,
    required this.userFullName,
    required this.title,
    required this.photos,
    required this.likeCount,
    required this.commentCount,
    required this.supportCount,
    required this.shareCount,
    required this.createdAt,
    this.interestId,
    this.interestName,
  });

  PostModel copyWith({String? interestName}) {
    return PostModel(
      id: id,
      userId: userId,
      userFullName: userFullName,
      title: title,
      photos: photos,
      likeCount: likeCount,
      commentCount: commentCount,
      supportCount: supportCount,
      shareCount: shareCount,
      createdAt: createdAt,
      interestId: interestId,
      interestName: interestName ?? this.interestName,
    );
  }

  Post toEntity() => Post(
    id: id,
    userId: userId,
    userFullName: userFullName,
    title: title,
    photos: photos,
    likeCount: likeCount,
    commentCount: commentCount,
    supportCount: supportCount,
    shareCount: shareCount,
    createdAt: createdAt,
    interestName: interestName,
  );

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] as String,
      userId: map['user_id'] as String? ?? '',
      userFullName: map['user_full_name'] as String? ?? '',
      title: map['title'] as String,
      photos: List<String>.from(map['photos'] as List),
      likeCount: map['likeCount'] as int? ?? 0,
      commentCount: map['commentCount'] as int? ?? 0,
      supportCount: map['supportCount'] as int? ?? 0,
      shareCount: map['shareCount'] as int? ?? 0,
      createdAt: _parseDateTime(map['createdAt']),
      interestId: map['interestId'] as String?,
    );
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is DateTime) return value;
    if (value is Timestamp) return value.toDate();
    return DateTime.parse(value as String);
  }
}
