import 'package:observer/entities/test_status.dart';
import 'package:observer/models/Interfaces/auth_model.dart';
import 'package:observer/models/Interfaces/database_model.dart';
import 'package:observer/models/auth_impl.dart';
import 'package:observer/models/database_impl.dart';
import 'package:observer/presenters/interfaces/tests_status_presenter.dart';
import 'package:observer/views/interfaces/tests_status_view.dart';

class TestsStatusImpl implements TestsStatusPresenter {
  TestsStatusView? _view;
  DatabaseModel _database = DatabaseImpl();
  AuthModel _auth = AuthImpl();

  @override
  void addTestClick(String name) {
    if (name == "") {
      _view?.showMassage("пустое имя");
      return;
    }
    String? link = _database.addEmptyTest(name);
    if (link == null) {
      _view?.showMassage("unknown error");
    } else {
      TestStatus testStatus = TestStatus(name: name, test: link, status: 2);
      _view?.addTestStatus(testStatus);
      String? uid = _auth.getUid();
      // _view?.showMassage(uid ?? "uiid");
      _database.addTestToAdmin(_auth.getUid() ?? "", testStatus);
    }
  }

  @override
  void logoutClick() {
    _auth.signOut();
  }

  @override
  void testStatusClick(TestStatus status) {
    if (status.status == 2) {
      _view?.openCreateTestPage(status);
    }
  }

  @override
  void setView(TestsStatusView view) {
    _view = view;
    _auth.setStateListener((user) {
      if (user == null) {
        _view?.openStartPage();
      }
    });
  }

  @override
  void removeTestStatusClick(TestStatus status) {
    String? uid = _auth.getUid();

    _database.removeTest(status.test);
    _database.removeTestStatus(uid ?? "", status.test);
    _view?.removeTestStatus(status);
  }

  @override
  void initialized() async {
    String? uid = _auth.getUid();

    List<TestStatus> res = await _database.getAdminTests(uid ?? "");

    for (var el in res) {
      _view?.addTestStatus(el);
    }
  }
}
