import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_learning/constants.dart';
import 'package:flutter_app_learning/models/user.dart';
import 'package:flutter_app_learning/services/api.dart';
import 'package:flutter_app_learning/utils/validations.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel extends ChangeNotifier with Validations {
  Api _api;

  LoginViewModel({@required Api api}) : _api = api;

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _rememberController = BehaviorSubject<bool>();

  // add data to stream
  Stream<String> get email =>
      _emailController.stream.transform(validateEmail).skip(1);

  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword).skip(1);

  Stream<bool> get checked => _rememberController.stream;

  Stream<bool> get loginValid =>
      Rx.combineLatest2(email, password, (e, p) => true);

  //change data
  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  Function(bool) get changeChecked => _rememberController.sink.add;

  final StreamController<User> _userController = StreamController<User>();

  Stream<User> get user => _userController.stream;

  Future<bool> login(LOGIN_TYPE type) async {
    var hasUser;
    await _api
        .login(type,
            email: _emailController.value, password: _passwordController.value)
        .then((value) {
      hasUser = value;
    });
    _userController.add(hasUser);
    print("_userController.add user : ${hasUser.toString()}");
    return hasUser != null;
  }

  Future<void> logout(LOGIN_TYPE type) async {
    _api.logout(type);
    _userController.add(null);
  }

  void singUp(String email, String password, String phone, String name) {}

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _rememberController.close();
    _userController.close();
    super.dispose();
  }
}
