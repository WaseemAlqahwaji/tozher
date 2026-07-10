class Post {
  final String id;
  final String title;
  final List<String> photos;
  final int likeCount;
  final int commentCount;
  final int supportCount;
  final int shareCount;
  final DateTime createdAt;
  final String? interestName;

  const Post({
    required this.id,
    required this.title,
    required this.photos,
    required this.likeCount,
    required this.commentCount,
    required this.supportCount,
    required this.shareCount,
    required this.createdAt,
    this.interestName,
  });
}
