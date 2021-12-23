import 'dart:convert';

class Human {
  String name;
  String surname;
  String email;
  bool isAdmin;
  Human({
    required this.name,
    required this.surname,
    required this.email,
    required this.isAdmin,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'email': email,
      'isAdmin': isAdmin,
    };
  }

  factory Human.fromMap(Map<String, dynamic> map) {
    return Human(
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      email: map['email'] ?? '',
      isAdmin: map['isAdmin'] ?? false,
    );
  }
}
