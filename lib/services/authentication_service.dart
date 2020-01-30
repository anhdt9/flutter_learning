import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';

class AuthenticationService {
  var _firebaseAuth = FirebaseAuth.instance;

  Future singUpWithEmail(
      {@required String email,
      @required String password,
      Function onSuccess}) async {
    var user = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
      print(error);
    });
    return user;
  }

  Future loginWithEmail(
      {@required String email, @required String password}) async {
    var user = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
      print(error);
    });
    return user;
  }

  _createUser(String userId, String name, String password) {
    var user = {"name": name, "password": password};
    var ref = FirebaseDatabase.instance.reference().child("user");
    ref.child(userId).set(user).then((userResult) {
      //success
    }).catchError((error) {
      //TODO handle error
      print(error);
    });
  }
}
