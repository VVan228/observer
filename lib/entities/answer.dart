import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:observer/entities/result.dart';

class Answer {
  Map<String, Result> results;
  Answer({
    required this.results,
  });

  Map<String, dynamic> toMap() {
    return {
      'results': results,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      results: Map<String, Result>.from(map['results']),
    );
  }
}
