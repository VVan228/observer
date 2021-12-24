import 'package:observer/entities/test_status.dart';

abstract class TestsStatusView {
  void showMassage(String s) {}
  void addTestStatus(TestStatus status) {}
  void removeTestStatus(TestStatus status) {}
  void openCreateTestPage(TestStatus test) {}
  void openStartPage() {}
  void openStatisticsPage(TestStatus status) {}
}
