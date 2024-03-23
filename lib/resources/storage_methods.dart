import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;

  Future<String> uploadFile({
    required String childName,
    required Uint8List file,
    required bool isPost,
  }) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot taskSnapshot = await uploadTask;

    return taskSnapshot.ref.getDownloadURL();
  }
}
