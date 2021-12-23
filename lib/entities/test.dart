import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:observer/entities/question.dart';

class Test {
  double maxRating;
  int status;
  int limitation;
  int start;
  List<Question> questions;
  List<String> humans;
  Test({
    required this.maxRating,
    required this.status,
    required this.limitation,
    required this.start,
    required this.questions,
    required this.humans,
  });

  Map<String, dynamic> toMap() {
    return {
      'maxRating': maxRating,
      'status': status,
      'limitation': limitation,
      'start': start,
      'questions': questions.map((x) => x.toMap()).toList(),
      'humans': humans,
    };
  }

  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
      maxRating: map['maxRating']?.toDouble() ?? 0.0,
      status: map['status']?.toInt() ?? 0,
      limitation: map['limitation']?.toInt() ?? 0,
      start: map['start']?.toInt() ?? 0,
      questions: List<Question>.from(
          map['questions']?.map((x) => Question.fromMap(x))),
      humans: List<String>.from(map['humans']),
    );
  }
}
