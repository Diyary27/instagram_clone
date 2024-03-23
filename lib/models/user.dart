import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String userName;
  final String uid;
  final String imageUrl;
  final String bio;
  final List followers;
  final List following;

  User(
      {required this.email,
      required this.userName,
      required this.uid,
      required this.imageUrl,
      required this.bio,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() => {
        "email": email,
        "userName": userName,
        "uid": uid,
        "imageUrl": imageUrl,
        "bio": bio,
        "followers": followers,
        "following": following
      };

  static User fromSnap(DocumentSnapshot snap) {
    final snapshot = snap.data() as Map<String, dynamic>;
    return User(
      email: snapshot['email'],
      userName: snapshot['username'],
      uid: snapshot['uid'],
      imageUrl: snapshot['imageUrl'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
