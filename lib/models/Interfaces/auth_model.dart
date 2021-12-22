import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthModel {
  Future<String> signUp(String email, String password) async {
    return "";
  }

  Future<String> signIn(String email, String password) async {
    return "";
  }

  Future<String> signOut() async {
    return "";
  }

  bool isLogged() {
    return false;
  }

  void setStateListener(Function(User?) f) {}
}
