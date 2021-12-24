import 'package:observer/entities/question.dart';
import 'package:observer/entities/test_status.dart';

abstract class CreateTestView {
  void showMassage(String s) {}
  void goBack() {}
  List<Question> getQuestions() {
    throw UnimplementedError();
  }

  TestStatus getTestStatus() {
    throw UnimplementedError();
  }

  void openAddHumansPage() {}

  List<String> getHumans() {
    throw UnimplementedError();
  }
}
