import 'package:flutter/material.dart';
import 'package:flutter_app_learning/TEST/pages/Login2.dart';
import 'package:flutter_app_learning/provider_setup.dart';
import 'package:flutter_app_learning/ui/route/local_route.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(LoginPage2());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.deepPurple),
        title: "FlutterLearningStructure",
        initialRoute: LocalRouter.LOGIN,
        onGenerateRoute: LocalRouter.generateRoute,
      ),
    );
  }
}
