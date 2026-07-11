import 'package:dartz/dartz.dart';
import 'package:tozher/features/core/domain/entity/failure.dart';
import 'package:tozher/features/posts/domain/entity/post.dart';
import 'package:tozher/features/posts/domain/params/post_add_params.dart';
import 'package:tozher/features/posts/domain/params/post_comment_add_params.dart';
import 'package:tozher/features/posts/domain/params/post_like_params.dart';
import 'package:tozher/features/posts/domain/params/post_share_params.dart';
import 'package:tozher/features/posts/domain/params/post_support_params.dart';

abstract class PostRepo {
  Future<Either<Failure, void>> addPost(PostAddParams params);
  Future<Either<Failure, List<Post>>> getPosts();

  Future<Either<Failure, void>> likePost(PostLikeParams params);
  Future<Either<Failure, void>> unlikePost(PostLikeParams params);
  Future<Either<Failure, void>> addComment(PostCommentAddParams params);
  Future<Either<Failure, void>> supportPost(PostSupportParams params);
  Future<Either<Failure, void>> sharePost(PostShareParams params);
}
