import 'dart:convert';

class TestStatus {
  String test;
  int status;
  TestStatus({
    required this.test,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'test': test,
      'status': status,
    };
  }

  factory TestStatus.fromMap(Map<String, dynamic> map) {
    return TestStatus(
      test: map['test'] ?? '',
      status: map['status']?.toInt() ?? 0,
    );
  }
}
