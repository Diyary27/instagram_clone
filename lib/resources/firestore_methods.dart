import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadPost({
    required String description,
    required Uint8List image,
  }) async {
    String res = 'a Problem has occured';

    try {
      // upload pic
      String postImageUrl = await StorageMethods()
          .uploadFile(childName: "posts", file: image, isPost: true);

      final user = await AuthMethods().getUserDetails();

      final postId = Uuid().v1();

      final Post post = Post(
        description: description,
        uid: user.uid,
        username: user.userName,
        postId: postId,
        datePublished: DateTime.now().toString(),
        postUrl: postImageUrl,
        profImage: user.imageUrl,
        likes: 0,
      );

      await _firestore.collection("posts").doc(postId).set(post.toJson());

      res = 'Success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
