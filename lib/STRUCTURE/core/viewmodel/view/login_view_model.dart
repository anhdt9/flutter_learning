import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_learning/STRUCTURE/core/service/AuthenticationService.dart';
import 'package:flutter_app_learning/STRUCTURE/core/util/Validations.dart';
import 'package:flutter_app_learning/STRUCTURE/core/viewmodel/base_view_model.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel extends BaseViewModel with Validations {
  AuthenticationService authenticationService;

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // add data to stream
  Stream<String> get email => _emailController.stream.transform(validateEmail).skip(1);
  Stream<String> get password => _passwordController.stream.transform(validatePassword).skip(1);
  Stream<bool> get loginValid => Observable.combineLatest2(email, password, (e, p) => true);

  //change data
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  login(){
    final email = _emailController.value;
    final password = _passwordController.value;
    print("login, email = $email, password = $password");
  }

  StreamController<ConnectivityResult> networkController = StreamController<ConnectivityResult>();

  LoginViewModel({@required AuthenticationService auth}) : authenticationService = auth {
    Connectivity()
        .onConnectivityChanged
        .listen((onData) => {networkController.add(onData)});
  }

  Future<bool> loginFb() async {
    busy = true;
    var hasUser = authenticationService.loginFb();
    busy = false;
    return hasUser != null;
  }

  Future<void> logoutFb() async {
    authenticationService.logoutFb();
  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    networkController.close();
    super.dispose();
  }
}
