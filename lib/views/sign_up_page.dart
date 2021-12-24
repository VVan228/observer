import 'package:flutter/material.dart';
import 'package:observer/main.dart';
import 'package:observer/models/Interfaces/auth_model.dart';
import 'package:observer/models/auth_impl.dart';
import 'package:observer/presenters/interfaces/sign_up_presenter.dart';
import 'package:observer/presenters/sign_up_impl.dart';
import 'package:observer/views/interfaces/sign_up_view.dart';
import 'package:observer/views/sign_in_page.dart';
import 'package:observer/views/test_search_page.dart';

import 'tests_status_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  SignUpPresenter presenter = SignUpImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 400,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(child: SignUpForm(presenter)),
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Уже зарегестрированы?"),
                        TextButton(
                          onPressed: () {
                            presenter.signInClick();
                          },
                          child: Text("Войти"),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  SignUpPresenter presenter;

  SignUpForm(this.presenter);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> implements SignUpView {
  AuthModel auth = AuthImpl();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordSubmitController = TextEditingController();

  bool isAdmin = false;

  String _msg = "";

  void _changeMsg(String m) {
    setState(() {
      _msg = m;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.presenter.setView(this);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Sign up', style: Theme.of(context).textTheme.headline4),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(hintText: 'email'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(hintText: 'password'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              controller: _passwordSubmitController,
              decoration: InputDecoration(hintText: 'submit password'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("буду админом"),
                Checkbox(
                    value: isAdmin,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          isAdmin = value;
                        });
                      }
                    }),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(8.0), child: Text(_msg)),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return Colors.white;
                }),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return Theme.of(context).colorScheme.secondary;
                }),
              ),
              onPressed: () {
                widget.presenter.submitClick(
                    _emailController.text,
                    _passwordController.text,
                    _passwordSubmitController.text,
                    isAdmin);
              },
              child: const Text('Sign up'),
            ),
          )
        ],
      ),
    );
  }

  @override
  void openSignIn() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  @override
  void showMassage(String msg) {
    _changeMsg(msg);
  }

  @override
  void openTestStatusPage() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TestsStatusPage()));
  }

  @override
  void openTestSearchPage() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TestSearchPage()));
  }
}
