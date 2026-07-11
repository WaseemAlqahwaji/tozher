import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tozher/features/posts/data/model/post_add_model.dart';
import 'package:tozher/features/posts/data/model/post_model.dart';

class PostSource {
  static const String _postsCollection = 'posts';
  static const String _likesCollection = 'likes';
  static const String _commentsCollection = 'comments';
  static const String _supportsCollection = 'supports';
  static const String _sharesCollection = 'shares';
  final FirebaseFirestore _firestore;

  PostSource(this._firestore);

  DocumentReference _postDoc(String postId) =>
      _firestore.collection(_postsCollection).doc(postId);

  // ---- Post CRUD ----

  Future<void> addPost(PostAddModel postAddModel) async {
    await _firestore.collection(_postsCollection).add(postAddModel.toMap());
  }

  Future<List<PostModel>> getPosts() async {
    final snapshot = await _firestore
        .collection(_postsCollection)
        .orderBy('createdAt', descending: true)
        .get();

    final posts = <PostModel>[];
    for (final doc in snapshot.docs) {
      final data = doc.data();
      data['id'] = doc.id;
      final model = PostModel.fromMap(data);

      // Resolve interest name from ID
      String? interestName;
      if (model.interestId != null && model.interestId!.isNotEmpty) {
        final interestDoc = await _firestore
            .collection('interests')
            .doc(model.interestId)
            .get();
        if (interestDoc.exists) {
          interestName = interestDoc.data()?['name'] as String?;
        }
      }

      posts.add(model.copyWith(interestName: interestName));
    }

    return posts;
  }

  // ---- Likes ----

  Future<void> likePost(String userId, String postId) async {
    final batch = _firestore.batch();
    batch.set(_postDoc(postId).collection(_likesCollection).doc(userId), {
      'user_id': userId,
      'created_at': FieldValue.serverTimestamp(),
    });
    batch.update(_postDoc(postId), {'likeCount': FieldValue.increment(1)});
    await batch.commit();
  }

  Future<void> unlikePost(String userId, String postId) async {
    final batch = _firestore.batch();
    batch.delete(_postDoc(postId).collection(_likesCollection).doc(userId));
    batch.update(_postDoc(postId), {'likeCount': FieldValue.increment(-1)});
    await batch.commit();
  }

  // ---- Comments ----

  Future<void> addComment(String userId, String postId, String text) async {
    final batch = _firestore.batch();
    batch.set(_postDoc(postId).collection(_commentsCollection).doc(), {
      'user_id': userId,
      'text': text,
      'created_at': FieldValue.serverTimestamp(),
    });
    batch.update(_postDoc(postId), {'commentCount': FieldValue.increment(1)});
    await batch.commit();
  }

  // ---- Supports ----

  Future<void> supportPost(String userId, String postId) async {
    final batch = _firestore.batch();
    batch.set(_postDoc(postId).collection(_supportsCollection).doc(userId), {
      'user_id': userId,
      'created_at': FieldValue.serverTimestamp(),
    });
    batch.update(_postDoc(postId), {'supportCount': FieldValue.increment(1)});
    await batch.commit();
  }

  // ---- Shares ----

  Future<void> sharePost(String userId, String postId) async {
    final batch = _firestore.batch();
    batch.set(_postDoc(postId).collection(_sharesCollection).doc(userId), {
      'user_id': userId,
      'created_at': FieldValue.serverTimestamp(),
    });
    batch.update(_postDoc(postId), {'shareCount': FieldValue.increment(1)});
    await batch.commit();
  }
}
