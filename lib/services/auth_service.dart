import 'package:firebase_auth/firebase_auth.dart';

// Service to Manage Authentication with Firebase
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? errorCode;
  String? errorMessage;

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      errorCode = null;
      return user;
    } on FirebaseAuthException catch (e) {
      errorCode = e.code;
      print(e.toString());
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      errorCode = e.code;
      errorMessage = e.message;
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
