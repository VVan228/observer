import 'dart:convert';

import 'package:flutter/foundation.dart';

class Result {
  String human;
  Map<String, double> rating;
  Result({
    required this.human,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'human': human,
      'rating': rating,
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      human: map['human'] ?? '',
      rating: Map<String, double>.from(map['rating']),
    );
  }
}
