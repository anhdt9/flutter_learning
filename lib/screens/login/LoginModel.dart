import 'dart:async';

import 'package:flutter_app_learning/data/User.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_app_learning/helper/Validation.dart';

class LoginModel {
  final _emailSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();
  final _uerSubject = BehaviorSubject<User>();

  var emailValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    sink.add(Validation.validateEmail(email));
  });

  var passValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (pass, sink) {
    sink.add(Validation.validationPass(pass));
  });

  Sink<String> get emailSink => _emailSubject.sink;

  Stream<String> get emailStream =>
      _emailSubject.stream.transform(emailValidation).skip(1);

  Sink<String> get passwordSink => _passwordSubject.sink;

  Stream<String> get passwordStream =>
      _passwordSubject.stream.transform(passValidation).skip(1);

  Sink<bool> get btnSink => _btnSubject.sink;

  Stream<bool> get btnStream => _btnSubject.stream;

  Sink<User> get userSink => _uerSubject.sink;

  Stream<User> get userStream => _uerSubject.stream;


  // email, password is Event dispatch from _emailSubject, _passwordSubject
  LoginModel() {
    Observable.combineLatest2(_emailSubject, _passwordSubject,
        (email, password) {
      return Validation.validateEmail(email) == null &&
          Validation.validationPass(password) == null;
    }).listen((enable) {
      btnSink.add(enable);
    });
  }

  dispose() {
    _emailSubject.close();
    _passwordSubject.close();
    _btnSubject.close();
    _uerSubject.close();
  }
}
