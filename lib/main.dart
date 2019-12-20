import 'package:flutter/material.dart';
import 'package:flutter_app_learning/provider_setup.dart';
import 'package:flutter_app_learning/STRUCTURE/ui/route/local_route.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
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
