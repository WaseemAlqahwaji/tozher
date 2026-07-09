import 'package:tozher/features/posts/data/source/post_source.dart';
import 'package:tozher/features/posts/domain/repo/post_repo.dart';

class PostRepoImpl extends PostRepo {
  final PostSource source;

  PostRepoImpl({required this.source});
}
