import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:observer/views/landing.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your applicationß
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
            return const LandingPage();
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
