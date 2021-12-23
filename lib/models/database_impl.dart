import 'package:firebase_database/firebase_database.dart';
import 'package:observer/entities/answer.dart';
import 'package:observer/entities/human.dart';
import 'package:observer/entities/question.dart';
import 'package:observer/entities/result.dart';
import 'package:observer/entities/test.dart';
import 'package:observer/entities/test_status.dart';
import 'package:observer/models/Interfaces/database_model.dart';

class DatabaseImpl implements DatabaseModel {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  DatabaseReference _testsRef() {
    return _database.ref("tests");
  }

  DatabaseReference _answersRef() {
    return _database.ref("answers");
  }

  DatabaseReference _humansRef() {
    return _database.ref("humans");
  }

  DatabaseReference _adminsRef() {
    return _database.ref("admins");
  }

  @override
  void addTest(Test test) {
    DatabaseReference ref = _testsRef();
    ref.push().set(test.toMap());
  }

  @override
  void addAnswerToTest(String test, Result result) {
    DatabaseReference ref = _answersRef().child(test);
    ref.push().set(result.toMap());
  }

  @override
  void addHuman(Human human) {
    DatabaseReference ref = _humansRef();
    ref.push().set(human.toMap());
  }

  @override
  void addTestToAdmin(String human, TestStatus testStatus) {
    DatabaseReference ref = _adminsRef().child(human);
    ref.push().set(testStatus);
  }

  @override
  Test getTest() {
    // TODO: implement getTest
    throw UnimplementedError();
  }
}
