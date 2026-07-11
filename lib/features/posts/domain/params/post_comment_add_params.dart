class PostCommentAddParams {
  final String userId;
  final String postId;
  final String text;
  final DateTime createdAt;

  PostCommentAddParams({
    required this.userId,
    required this.postId,
    required this.text,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
