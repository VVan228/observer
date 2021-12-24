import 'dart:convert';

class Human {
  bool isAdmin;
  String email;
  String uid;
  Human({
    required this.isAdmin,
    required this.email,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'isAdmin': isAdmin,
      'email': email,
      'uid': uid,
    };
  }

  factory Human.fromMap(Map<String, dynamic> map) {
    return Human(
      isAdmin: map['isAdmin'] ?? false,
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
    );
  }
}
