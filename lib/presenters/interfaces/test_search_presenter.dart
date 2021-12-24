import 'package:observer/views/interfaces/test_search_view.dart';

abstract class TestSearchPresenter {
  void searchClick(String q) {}
  void applyClick() {}
  void setView(TestSearchView view) {}
  void logoutClick() {}
}
