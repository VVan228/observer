import 'dart:convert';

import 'package:flutter/foundation.dart';

class Result {
  String human;
  String email;
  double sumRating;
  double sumMaxRating;
  Map<String, double> rating;
  Map<String, double> maxRating;
  Result({
    required this.human,
    required this.email,
    required this.sumRating,
    required this.sumMaxRating,
    required this.rating,
    required this.maxRating,
  });

  Map<String, dynamic> toMap() {
    return {
      'human': human,
      'email': email,
      'sumRating': sumRating,
      'sumMaxRating': sumMaxRating,
      'rating': rating,
      'maxRating': maxRating,
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      human: map['human'] ?? '',
      email: map['email'] ?? '',
      sumRating: map['sumRating']?.toDouble() ?? 0.0,
      sumMaxRating: map['sumMaxRating']?.toDouble() ?? 0.0,
      rating: Map<String, double>.from(map['rating'] ?? {}),
      maxRating: Map<String, double>.from(map['maxRating'] ?? {}),
    );
  }
}
