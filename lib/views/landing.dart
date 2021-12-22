import 'package:flutter/material.dart';
import 'package:observer/models/Interfaces/auth_model.dart';
import 'package:observer/models/auth_impl.dart';
import 'package:observer/views/sign_in.dart';
import 'package:observer/views/sign_up.dart';

import 'home.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthModel auth = AuthImpl();
    bool isLogged = auth.isLogged();

    return isLogged
        ? const HomePage(
            title: "logged lol",
          )
        : SignUpPage();
  }
}
