import 'dart:async';

import 'package:flutter_app_learning/STRUCTURE/core/model/User.dart';
import 'package:flutter_app_learning/STRUCTURE/core/service/API.dart';

class AuthenticationService {
  Api _api;

  AuthenticationService({Api api}): _api = api;

  StreamController<User> _controller = StreamController<User>();

  Stream<User> get user => _controller.stream;

  Future<bool> loginFb() async {
    var fetchedUser = await _api.loginFb();
    var hasUser = fetchedUser != null;
    if (hasUser) {
      _controller.add(fetchedUser);
    }
    return hasUser;
  }

  Future logoutFb() async {
    await _api.logoutFb();
    _controller.add(null);
  }
}
