import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String userName,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty ||
          userName.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          file.isNotEmpty) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);

        // upload image
        String photoUrl = await StorageMethods().uploadImageToStorage(
            childName: "profilePics", file: file, isPost: false);

        // add user to database
        await firestore.collection("users").doc(cred.user!.uid).set({
          "email": email,
          "userName": userName,
          "bio": bio,
          "uid": cred.user!.uid,
          "followers": [],
          "following": [],
          "photoUrl": photoUrl,
        });

        res = "success";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
