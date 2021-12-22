import 'package:observer/presenters/interfaces/sign_up_presenter.dart';
import 'package:observer/views/interfaces/sign_up_view.dart';

import '../models/Interfaces/auth_model.dart';
import '../models/auth_impl.dart';

class SignUpImpl implements SignUpPresenter {
  final AuthModel _authModel = AuthImpl();
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
  void submitClick(String email, String password, String submitPassword) async {
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
      _view?.openHomePage();
    } else {
      _view?.showMassage(res);
    }
  }
}
