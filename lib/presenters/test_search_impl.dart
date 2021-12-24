import 'package:observer/entities/answer.dart';
import 'package:observer/entities/question.dart';
import 'package:observer/entities/result.dart';
import 'package:observer/entities/test.dart';
import 'package:observer/models/Interfaces/auth_model.dart';
import 'package:observer/models/Interfaces/database_model.dart';
import 'package:observer/models/auth_impl.dart';
import 'package:observer/models/database_impl.dart';
import 'package:observer/presenters/interfaces/test_search_presenter.dart';
import 'package:observer/views/interfaces/test_search_view.dart';

class TestSearchImpl implements TestSearchPresenter {
  TestSearchView? _view;
  DatabaseModel _database = DatabaseImpl();
  AuthModel _auth = AuthImpl();
  List<Question>? questions;
  // String t = "";
  Test? _test;
  String? _link;

  @override
  void applyClick() async {
    Map<String, List<String>>? answers = _view?.getAnswers();
    if (answers == null || answers.isEmpty) {
      _view?.showMassage("найдите тест");
      return;
    }
    if (questions == null) {
      _view?.showMassage("неизвестная ошибка, куда ты дел вопросы???");
      return;
    }
    String? uid = _auth.getUid();

    bool hasAnswered = await _database.hasAnsweredTest(uid ?? "", _link ?? "");
    if (hasAnswered) {
      _view?.showMassage("вы уже давали ответ на этот тест");
      return;
    }

    Map<String, double> rating = {};
    double totalScore = 0;
    Result res = Result(human: uid ?? "", rating: rating);
    for (Question q in questions!) {
      int total = q.right.length;
      int cur = 0;
      for (int i = 0; i < answers[q.question]!.length; i++) {
        if (q.right.contains(answers[q.question]![i])) {
          cur++;
        }
      }
      double score = cur / total;
      totalScore += score;
      rating[q.question] = score * q.factor;
    }

    _database.addAnswerToTest(_link ?? "", res);
    _view?.showImportantMassage(totalScore.toString() +
        " из " +
        _test!.maxRating.toString() +
        " -- " +
        (100 * totalScore / _test!.maxRating).toString() +
        "%");
  }

  @override
  void searchClick(String q) async {
    if (q == "") {
      _view?.showMassage("пустой запрос!");
      return;
    }

    Test? test = await _database.getTest(q);
    if (test == null) {
      _view?.showMassage("тест не найден");
      return;
    }

    String? email = _auth.getEmail();
    bool isInList = test.humans.contains(email ?? "");
    if (!isInList && test.humans.isNotEmpty) {
      _view?.showMassage("вас нет в списке");
      return;
    }

    _test = test;
    _link = q;

    questions = test.questions;
    for (Question q in test.questions) {
      List<String> answ = [];
      answ.addAll(q.right);
      answ.addAll(q.wrong);
      answ.shuffle();
      _view?.addQuestion(q.question, answ);
    }
  }

  @override
  void setView(TestSearchView view) {
    _view = view;
    _auth.setStateListener((user) {
      if (user == null) {
        _view?.openStartPage();
      }
    });
  }

  @override
  void logoutClick() {
    _auth.signOut();
  }
}
