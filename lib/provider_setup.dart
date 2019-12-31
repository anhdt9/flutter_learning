import 'package:flutter_app_learning/core/model/User.dart';
import 'package:flutter_app_learning/core/service/API.dart';
import 'package:flutter_app_learning/core/viewmodel/view/login_view_model.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

List<SingleChildWidget> appProviders = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

List<SingleChildWidget> independentServices = [Provider.value(value: Api())];

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
