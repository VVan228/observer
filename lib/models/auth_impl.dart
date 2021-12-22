import 'package:firebase_auth/firebase_auth.dart';
import 'package:observer/models/Interfaces/auth_model.dart';

class AuthImpl implements AuthModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<String> signUp(String email, String password) async {
    try {
      UserCredential res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        return "The account already exists for that email.";
      } else {
        return e.code;
      }
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return "";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        return "Wrong password provided for that user.";
      } else {
        return e.code;
      }
    }
  }

  @override
  Future<String> signOut() async {
    _auth.signOut();
    return "";
  }

  @override
  bool isLogged() {
    return _auth.currentUser != null;
  }
}
