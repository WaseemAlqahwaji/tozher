class PostCommentAddParams {
  final String userId;
  final String postId;
  final String text;

  PostCommentAddParams({
    required this.userId,
    required this.postId,
    required this.text,
  });
}
