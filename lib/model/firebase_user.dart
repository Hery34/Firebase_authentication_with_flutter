import 'package:firebase_auth/firebase_auth.dart';

//FirebaseUser data model

class FirebaseUser {
  final String uid;
  final String? displayName;
  final String email;
  final DateTime creationTime;
  final DateTime? lastSignInTime;
  final String? photoURL;

  FirebaseUser({
    required this.uid,
    this.displayName,
    required this.email,
    required this.creationTime,
    this.lastSignInTime,
    this.photoURL,
  });

  factory FirebaseUser.fromFireBaseUser(User user) {
    return FirebaseUser(
      uid: user.uid,
      displayName: user.displayName,
      email: user.email!,
      creationTime: user.metadata.creationTime!,
      lastSignInTime: user.metadata.lastSignInTime,
      photoURL: user.photoURL,
    );
  }
}
