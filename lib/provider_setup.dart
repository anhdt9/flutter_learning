import 'package:flutter_app_learning/services/api.dart';
import 'package:flutter_app_learning/viewmodels/LoginViewModel.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

List<SingleChildWidget> appProviders = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

List<SingleChildWidget> independentServices = [
  Provider.value(value: Api.get())
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<Api, LoginViewModel>(
    update: (context, api, loginModel) => LoginViewModel(api: api),
  )
];
List<SingleChildWidget> uiConsumableProviders = [
  StreamProvider<User>(
    create: (context) =>
        Provider.of<LoginViewModel>(context, listen: false).user,
  )
];
