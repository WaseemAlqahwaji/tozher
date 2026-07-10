import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tozher/features/posts/data/model/post_add_model.dart';
import 'package:tozher/features/posts/data/model/post_model.dart';

class PostSource {
  final String collectionName = 'posts';
  final FirebaseFirestore _firestore;

  PostSource(this._firestore);

  Future<void> addPost(PostAddModel postAddModel) async {
    await _firestore.collection(collectionName).add(postAddModel.toMap());
  }

  Future<List<PostModel>> getPosts() async {
    final snapshot = await _firestore
        .collection(collectionName)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs
        .map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return PostModel.fromMap(
            data,
            data['interestId'] as String?,
          );
        })
        .toList();
  }
}
