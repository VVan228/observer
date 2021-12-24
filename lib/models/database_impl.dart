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
  void updateTest(String link, Test test) {
    DatabaseReference ref = _testsRef().child(link);
    ref.set(test.toMap());
  }

  @override
  void addAnswerToTest(String test, Result result) {
    DatabaseReference ref = _answersRef().child(test).child(result.human);
    ref.set(result.toMap());
  }

  @override
  void addHuman(Human human) {
    DatabaseReference ref = _humansRef().child(human.uid);
    ref.set(human.toMap());
  }

  @override
  void addTestToAdmin(String human, TestStatus testStatus) {
    DatabaseReference ref = _adminsRef().child(human).child(testStatus.test);
    ref.set(testStatus.toMap());
  }

  @override
  Future<Test?> getTest(String test) async {
    DatabaseReference ref = _testsRef().child(test);
    DataSnapshot snap = await ref.get();
    if (snap.value == null) {
      return null;
    }
    Map<String, dynamic> res = snap.value as Map<String, dynamic>;
    return Test.fromMap(res);
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

  @override
  void updateTestStatus(String human, TestStatus testStatus) {
    DatabaseReference ref = _adminsRef().child(human).child(testStatus.test);
    ref.set(testStatus.toMap());
  }

  @override
  Future<bool> isAdmin(String human) async {
    DatabaseReference ref = _humansRef().child(human);
    DataSnapshot snap = await ref.get();
    Map<String, dynamic> res = snap.value as Map<String, dynamic>;
    return Human.fromMap(res).isAdmin;
  }

  @override
  Future<bool> hasAnsweredTest(String human, String test) async {
    DatabaseReference ref = _answersRef().child(test).child(human);
    DataSnapshot snap = await ref.get();

    return snap.value != null;
  }
}
