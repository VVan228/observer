import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:observer/entities/test_status.dart';

class Admin {
  List<TestStatus> tests;
  Admin({
    required this.tests,
  });

  Map<String, dynamic> toMap() {
    return {
      'tests': tests.map((x) => x.toMap()).toList(),
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      tests: List<TestStatus>.from(
          map['tests']?.map((x) => TestStatus.fromMap(x))),
    );
  }
}
