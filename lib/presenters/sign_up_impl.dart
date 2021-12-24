import 'package:observer/entities/human.dart';
import 'package:observer/models/Interfaces/database_model.dart';
import 'package:observer/models/database_impl.dart';
import 'package:observer/presenters/interfaces/sign_up_presenter.dart';
import 'package:observer/views/interfaces/sign_up_view.dart';

import '../models/Interfaces/auth_model.dart';
import '../models/auth_impl.dart';

class SignUpImpl implements SignUpPresenter {
  final AuthModel _authModel = AuthImpl();
  final DatabaseModel _database = DatabaseImpl();
  SignUpView? _view;

  @override
  void setView(SignUpView view) {
    _view = view;
  }

  @override
  void signInClick() {
    _view?.openSignIn();
  }

  @override
  void submitClick(String email, String password, String submitPassword,
      bool isAdmin) async {
    if (password.length < 6) {
      _view?.showMassage("password kinda weak");
      return;
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      _view?.showMassage("wtf this email");
      return;
    }
    if (password != submitPassword) {
      _view?.showMassage("passwords don't match");
      return;
    }
    String res = await _authModel.signUp(email, password);
    if (res == "") {
      String? uid = _authModel.getUid();
      // String? email = _authModel.getEmail();

      _database.addHuman(Human(email: email, isAdmin: isAdmin, uid: uid ?? ""));

      if (isAdmin) {
        _view?.openTestStatusPage();
      } else {
        _view?.openTestSearchPage();
      }
    } else {
      _view?.showMassage(res);
    }
  }
}
