import 'package:flutter/material.dart';

import 'screens/login/LoginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FlutterLearning",
      theme: new ThemeData(primaryColor: Colors.blue),
      home: LoginScreen(),
    );
  }
}
