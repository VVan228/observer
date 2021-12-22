import 'package:flutter/material.dart';
import 'package:observer/main.dart';
import 'package:observer/models/Interfaces/auth_model.dart';
import 'package:observer/models/auth_impl.dart';

import 'home.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

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
                Card(child: SignInForm()),
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  AuthModel auth = AuthImpl();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {},
              ),
              Text('Sign in', style: Theme.of(context).textTheme.headline4),
              const SizedBox(
                width: 32,
              )
            ],
          ),
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
