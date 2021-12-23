import 'dart:convert';

import 'package:flutter/foundation.dart';

class Question {
  int type;
  double factor;
  List<String> right;
  List<String> wrong;
  Question({
    required this.type,
    required this.factor,
    required this.right,
    required this.wrong,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'factor': factor,
      'right': right,
      'wrong': wrong,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      type: map['type']?.toInt() ?? 0,
      factor: map['factor']?.toDouble() ?? 0.0,
      right: List<String>.from(map['right']),
      wrong: List<String>.from(map['wrong']),
    );
  }
}
