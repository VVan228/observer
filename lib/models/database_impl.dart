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
    DatabaseReference ref = _adminsRef().child(human).child(testStatus.test);
    ref.set(testStatus.toMap());
  }

  @override
  Test getTest() {
    // TODO: implement getTest
    throw UnimplementedError();
  }

  @override
  String? addEmptyTest(String name) {
    DatabaseReference ref = _testsRef();
    ref = ref.push();
    ref.set(Test(
        name: name,
        maxRating: 0,
        status: 0,
        limitation: 0,
        start: 0,
        questions: [],
        humans: []).toMap());
    return ref.key;
  }

  @override
  void removeTest(String test) {
    DatabaseReference ref = _testsRef().child(test);
    ref.remove();
  }

  @override
  void removeTestStatus(String human, String test) async {
    DatabaseReference ref = _adminsRef().child(human).child(test);
    ref.remove();
  }

  @override
  Future<List<TestStatus>> getAdminTests(String human) async {
    List<TestStatus> res = [];
    DatabaseReference ref = _adminsRef().child(human);
    DataSnapshot snap = await ref.get();
    for (DataSnapshot element in snap.children) {
      Map<String, dynamic> status = element.value as Map<String, dynamic>;
      res.add(TestStatus.fromMap(status));
    }
    return res;
  }
}
