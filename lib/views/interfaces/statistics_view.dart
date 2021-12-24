import 'package:observer/entities/test_status.dart';

import '../../entities/result.dart';

abstract class StatisticsView {
  void addResult(Result result) {}
  TestStatus getTestLink() {
    throw UnimplementedError();
  }

  void showMassage(String s) {}
}
