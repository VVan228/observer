import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:observer/views/sign_up_page.dart';
import 'package:observer/views/tests_status_page.dart';

import 'models/Interfaces/auth_model.dart';
import 'models/auth_impl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            debugPrint('error');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            AuthModel auth = AuthImpl();
            bool isLogged = auth.isLogged();

            return isLogged ? TestsStatusPage() : SignUpPage();
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
