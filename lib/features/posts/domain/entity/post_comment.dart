class PostComment {
  final String id;
  final String userId;
  final String text;
  final DateTime createdAt;

  const PostComment({
    required this.id,
    required this.userId,
    required this.text,
    required this.createdAt,
  });

  factory PostComment.fromMap(String id, Map<String, dynamic> map) {
    return PostComment(
      id: id,
      userId: map['user_id'] as String? ?? '',
      text: map['text'] as String? ?? '',
      createdAt: (map['created_at'] as dynamic)?.toDate() ?? DateTime.now(),
    );
  }
}
