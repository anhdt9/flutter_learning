import 'dart:async';

import 'package:flutter_app_learning/STRUCTURE/core/model/User.dart';
import 'package:flutter_app_learning/STRUCTURE/core/service/API.dart';
import 'package:flutter_app_learning/STRUCTURE/core/service/AuthenticationService.dart';
import 'package:provider/provider.dart';

List<SingleChildCloneableWidget> appProviders = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

List<SingleChildCloneableWidget> independentServices = [
  Provider.value(value: Api())
];

List<SingleChildCloneableWidget> dependentServices = [
  ProxyProvider<Api, AuthenticationService>(
    update: (context, api, authenticationService) =>
        AuthenticationService(api: api),
  )
];
List<SingleChildCloneableWidget> uiConsumableProviders = [
  StreamProvider<User>(
    create: (context) =>
        Provider.of<AuthenticationService>(context, listen: false).user,
  )
];
