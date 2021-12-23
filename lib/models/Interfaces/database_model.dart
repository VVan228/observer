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
    throw UnimplementedError();
  }

  Future<List<TestStatus>> getAdminTests(String human) {
    throw UnimplementedError();
  }

  String? addEmptyTest(String name) {}
  void removeTest(String test) {}
  void removeTestStatus(String human, String test) {}
}
