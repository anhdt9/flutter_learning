import 'package:flutter/material.dart';
import 'package:flutter_app_learning/route/AppRoute.dart';

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
      initialRoute: AppRoute.getInitRoute(context),
      routes: AppRoute.getAppRoute(context),
      theme: new ThemeData(primaryColor: Colors.blue),
      home: LoginScreen(),
    );
  }
}
