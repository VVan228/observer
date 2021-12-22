import 'package:flutter/material.dart';
import 'package:observer/main.dart';
import 'package:observer/models/Interfaces/auth_model.dart';
import 'package:observer/models/auth_impl.dart';

import 'home.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

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
                Card(child: SignUpForm()),
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Если вы уже зарегестрированы, то "),
                        TextButton(
                          onPressed: () {},
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
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  AuthModel auth = AuthImpl();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordSubmitController = TextEditingController();

  String _msg = "";

  void _changeMsg(String m) {
    setState(() {
      _msg = m;
    });
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
              controller: _passwordController,
              decoration: InputDecoration(hintText: 'password'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _passwordSubmitController,
              decoration: InputDecoration(hintText: 'submit password'),
            ),
          ),
          Padding(padding: EdgeInsets.all(8.0), child: Text(_msg)),
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
                debugPrint("pressed");
                auth
                    .signUp(_emailController.text, _passwordController.text)
                    .then((value) => value == ""
                        ? _changeMsg("success")
                        : _changeMsg(value));
              },
              child: Text('Sign up'),
            ),
          )
        ],
      ),
    );
  }
}
