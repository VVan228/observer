import 'package:observer/entities/human.dart';
import 'package:observer/entities/result.dart';
import 'package:observer/entities/test.dart';
import 'package:observer/entities/test_status.dart';

abstract class DatabaseModel {
  void addTest(Test test) {}
  void addHuman(Human human) {}
  void addTestToAdmin(String human, TestStatus testStatus) {}
  void addAnswerToTest(String test, Result result) {}
  Test getTest() {
    return Test(
        maxRating: 0,
        status: 0,
        limitation: 0,
        start: 0,
        questions: [],
        humans: []);
  }
}
