import 'package:tozher/features/interests/data/model/interest_model.dart';
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
  final DateTime updatedAt;
  final List<InterestModel> interests;

  PostModel({
    required this.id,
    required this.title,
    required this.photos,
    required this.likeCount,
    required this.commentCount,
    required this.supportCount,
    required this.shareCount,
    required this.createdAt,
    required this.updatedAt,
    required this.interests,
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
    updatedAt: updatedAt,
    interestsNames: interests.map((interest) => interest.name).toList(),
  );

  factory PostModel.fromMap(
    Map<String, dynamic> map,
    List<InterestModel> interests,
  ) {
    return PostModel(
      id: map['id'] as String,
      title: map['title'] as String,
      photos: List<String>.from(map['photos'] as List<String>),
      likeCount: map['likeCount'] as int,
      commentCount: map['commentCount'] as int,
      supportCount: map['supportCount'] as int,
      shareCount: map['shareCount'] as int,
      createdAt: _parseDateTime(map['createdAt']),
      updatedAt: _parseDateTime(map['updatedAt']),
      interests: interests,
    );
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is DateTime) return value;
    return DateTime.parse(value as String);
  }
}
