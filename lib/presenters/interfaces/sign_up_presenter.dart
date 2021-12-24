import 'package:observer/views/interfaces/sign_up_view.dart';

abstract class SignUpPresenter {
  void submitClick(
      String email, String password, String submitPassword, bool isAdmin) {}
  void signInClick() {}
  void setView(SignUpView view) {}
}
