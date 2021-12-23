import 'dart:convert';

class TestStatus {
  String name;
  String test;
  int status;
  TestStatus({
    required this.name,
    required this.test,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'test': test,
      'status': status,
    };
  }

  factory TestStatus.fromMap(Map<String, dynamic> map) {
    return TestStatus(
      name: map['name'] ?? '',
      test: map['test'] ?? '',
      status: map['status']?.toInt() ?? 0,
    );
  }
}
