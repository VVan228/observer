import 'package:observer/views/interfaces/sign_in_view.dart';

abstract class SignInPresenter {
  void submitClick(String email, String password) {}
  void backClick() {}
  void setView(SignInView view) {}
}
