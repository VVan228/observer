import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:observer/entities/result.dart';

class Answer {
  List<Result> results;
  Answer({
    required this.results,
  });

  Map<String, dynamic> toMap() {
    return {
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      results: List<Result>.from(map['results']?.map((x) => Result.fromMap(x))),
    );
  }
}
