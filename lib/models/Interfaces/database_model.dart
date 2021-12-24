import 'package:observer/entities/human.dart';
import 'package:observer/entities/result.dart';
import 'package:observer/entities/test.dart';
import 'package:observer/entities/test_status.dart';

abstract class DatabaseModel {
  void updateTest(String link, Test test) {}
  void updateTestStatus(String human, TestStatus testStatus) {}
  void addTestToAdmin(String human, TestStatus testStatus) {}
  void addAnswerToTest(String test, Result result) {}
  Future<Test?> getTest(String test) {
    throw UnimplementedError();
  }

  Future<List<TestStatus>> getAdminTests(String human) {
    throw UnimplementedError();
  }

  String? addEmptyTest(String name) {}
  void removeTest(String test) {}
  void removeTestStatus(String human, String test) {}

  void addHuman(Human human) {}
  Future<bool> isAdmin(String human) {
    throw UnimplementedError();
  }

  Future<bool> hasAnsweredTest(String human, String test) {
    throw UnimplementedError();
  }

  Future<List<Result?>> getResultsFromTest(String test) {
    throw UnimplementedError();
  }
}
