import 'package:dartz/dartz.dart';
import 'package:tozher/features/core/domain/entity/failure.dart';
import 'package:tozher/features/core/error/error_converter.dart';
import 'package:tozher/features/posts/data/model/post_add_model.dart';
import 'package:tozher/features/posts/data/source/post_source.dart';
import 'package:tozher/features/posts/domain/entity/post.dart';
import 'package:tozher/features/posts/domain/params/post_add_params.dart';
import 'package:tozher/features/posts/domain/params/post_comment_add_params.dart';
import 'package:tozher/features/posts/domain/params/post_like_params.dart';
import 'package:tozher/features/posts/domain/params/post_share_params.dart';
import 'package:tozher/features/posts/domain/params/post_support_params.dart';
import 'package:tozher/features/posts/domain/repo/post_repo.dart';

class PostRepoImpl extends PostRepo {
  final PostSource source;

  PostRepoImpl({required this.source});

  @override
  Future<Either<Failure, void>> addPost(PostAddParams params) async {
    return ErrorConverter.safeCall<void>(() async {
      final model = params.toModel();
      await source.addPost(model);
    });
  }

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    return ErrorConverter.safeCall<List<Post>>(() async {
      final models = await source.getPosts();
      return models.map((m) => m.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, void>> likePost(PostLikeParams params) async {
    return ErrorConverter.safeCall<void>(() async {
      await source.likePost(params.userId, params.postId);
    });
  }

  @override
  Future<Either<Failure, void>> unlikePost(PostLikeParams params) async {
    return ErrorConverter.safeCall<void>(() async {
      await source.unlikePost(params.userId, params.postId);
    });
  }

  @override
  Future<Either<Failure, void>> addComment(PostCommentAddParams params) async {
    return ErrorConverter.safeCall<void>(() async {
      await source.addComment(params.userId, params.postId, params.text);
    });
  }

  @override
  Future<Either<Failure, void>> supportPost(PostSupportParams params) async {
    return ErrorConverter.safeCall<void>(() async {
      await source.supportPost(params.userId, params.postId);
    });
  }

  @override
  Future<Either<Failure, void>> sharePost(PostShareParams params) async {
    return ErrorConverter.safeCall<void>(() async {
      await source.sharePost(params.userId, params.postId);
    });
  }
}
