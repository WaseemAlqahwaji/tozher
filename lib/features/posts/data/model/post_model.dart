import 'package:tozher/features/posts/domain/entity/post.dart';

class PostModel {
  final String id;
  final String title;
  final List<String> photos;
  final int likeCount;
  final int commentCount;
  final int supportCount;
  final int shareCount;
  final DateTime createdAt;
  final String? interestId;

  PostModel({
    required this.id,
    required this.title,
    required this.photos,
    required this.likeCount,
    required this.commentCount,
    required this.supportCount,
    required this.shareCount,
    required this.createdAt,
    this.interestId,
  });

  Post toEntity() => Post(
    id: id,
    title: title,
    photos: photos,
    likeCount: likeCount,
    commentCount: commentCount,
    supportCount: supportCount,
    shareCount: shareCount,
    createdAt: createdAt,
    interestName: interestId,
  );

  factory PostModel.fromMap(
    Map<String, dynamic> map,
    String? interestId,
  ) {
    return PostModel(
      id: map['id'] as String,
      title: map['title'] as String,
      photos: List<String>.from(map['photos'] as List),
      likeCount: map['likeCount'] as int,
      commentCount: map['commentCount'] as int,
      supportCount: map['supportCount'] as int,
      shareCount: map['shareCount'] as int,
      createdAt: _parseDateTime(map['createdAt']),
      interestId: interestId,
    );
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is DateTime) return value;
    return DateTime.parse(value as String);
  }
}
