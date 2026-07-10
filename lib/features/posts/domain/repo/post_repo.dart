import 'package:dartz/dartz.dart';
import 'package:tozher/features/core/domain/entity/failure.dart';
import 'package:tozher/features/posts/domain/entity/post.dart';
import 'package:tozher/features/posts/domain/params/post_add_params.dart';

abstract class PostRepo {
  Future<Either<Failure, void>> addPost(PostAddParams params);
  Future<Either<Failure, List<Post>>> getPosts();
}
