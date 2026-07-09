class Achievement {
  final String id;
  final String title;
  final bool isDone;

  const Achievement({
    required this.id,
    required this.title,
    required this.isDone,
  });

  Achievement copyWith({
    String? id,
    String? title,
    bool? isDone,
  }) {
    return Achievement(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}
