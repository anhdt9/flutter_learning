import 'package:flutter_app_learning/core/model/User.dart';
import 'package:flutter_app_learning/core/service/API.dart';
import 'package:flutter_app_learning/core/viewmodel/view/login_view_model.dart';
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
  ProxyProvider<Api, LoginViewModel>(
    update: (context, api, loginModel) => LoginViewModel(api: api),
  )
];
List<SingleChildCloneableWidget> uiConsumableProviders = [
  StreamProvider<User>(
    create: (context) => Provider.of<LoginViewModel>(context, listen: false).user,
  )
];
