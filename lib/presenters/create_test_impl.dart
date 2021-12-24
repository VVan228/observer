import 'package:observer/entities/question.dart';
import 'package:observer/entities/test.dart';
import 'package:observer/entities/test_status.dart';
import 'package:observer/models/Interfaces/auth_model.dart';
import 'package:observer/models/Interfaces/database_model.dart';
import 'package:observer/models/auth_impl.dart';
import 'package:observer/models/database_impl.dart';
import 'package:observer/presenters/interfaces/create_test_presenter.dart';
import 'package:observer/views/interfaces/create_test_view.dart';

class CreateTestImpl implements CreateTestPresenter {
  DatabaseModel _database = DatabaseImpl();
  AuthModel _auth = AuthImpl();
  CreateTestView? _view;

  @override
  void saveClick() {
    List<Question>? questions = _view?.getQuestions();
    List<String>? humans = _view?.getHumans();
    TestStatus? test = _view?.getTestStatus();
    if (test != null && questions != null && humans != null) {
      double maxRating = 0.0;
      for (int i = 0; i < questions.length; i++) {
        maxRating += questions[i].type * questions[i].factor;
      }
      _database.updateTest(
          test.test,
          Test(
              name: test.name,
              maxRating: maxRating,
              status: 1,
              limitation: 0,
              start: 0,
              questions: questions,
              humans: humans));
      String? uid = _auth.getUid();

      test.status = 1;
      _database.updateTestStatus(uid ?? "", test);

      _view?.goBack();
    }
  }

  @override
  void setView(CreateTestView view) {
    _view = view;
  }

  @override
  void addPeopleClick() {
    _view?.openAddHumansPage();
  }
}
