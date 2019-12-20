import 'dart:async';

class Validations {

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink) {
    var isValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if (isValid) {
      sink.add(email);
    } else {
      sink.addError('Email invalid');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 6) {
      sink.add(password);
    } else {
      sink.addError('Invalid password, please enter more than 6 characters');
    }
  });
}
