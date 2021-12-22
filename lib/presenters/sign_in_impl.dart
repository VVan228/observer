import 'package:observer/models/Interfaces/auth_model.dart';
import 'package:observer/models/auth_impl.dart';
import 'package:observer/presenters/interfaces/sign_in_presenter.dart';
import 'package:observer/views/interfaces/sign_in_view.dart';

class SignInImpl implements SignInPresenter {
  final AuthModel _authModel = AuthImpl();
  SignInView? _view;

  @override
  void backClick() {
    _view?.backToSignUp();
  }

  @override
  void submitClick(String email, String password) async {
    String res = await _authModel.signIn(email, password);
    if (res == "") {
      _view?.openHomePage();
    } else {
      _view?.showMassage(res);
    }
  }

  @override
  void setView(SignInView view) {
    _view = view;
  }
}
