import 'package:flutter/material.dart';
import 'package:flutter_app_learning/local_route.dart';
import 'package:flutter_app_learning/provider_setup.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LocalRouter.LOGIN,
        onGenerateRoute: LocalRouter.generateRoute,
      ),
    );
  }
}
