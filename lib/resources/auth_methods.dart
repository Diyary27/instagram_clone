import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:instagram_clone/models/user.dart' as model;

class AuthMethods {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // get user
  Future<model.User> getUserDetails() async {
    final User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    final model.User userModel = model.User.fromSnap(snap);

    return userModel;
  }

  // Signup user
  Future<String> signup({
    required String username,
    required String email,
    required String password,
    required String bio,
    required Uint8List image,
  }) async {
    String res = "An error has occurred";
    try {
      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final String imageUrl = await StorageMethods()
          .uploadFile(childName: "profilePics", file: image, isPost: false);

      // create model instance
      model.User user = model.User(
        email: email,
        userName: username,
        uid: credential.user!.uid,
        imageUrl: imageUrl,
        bio: bio,
        followers: [],
        following: [],
      );

      // add it to firebase
      await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(user.toJson());

      res = 'Success';
    } on FirebaseAuthException catch (err) {
      res = err.code;
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // Login user
  Future<String> login({
    required String email,
    required String password,
  }) async {
    String res = "An error has occurred";

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      res = 'Success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
