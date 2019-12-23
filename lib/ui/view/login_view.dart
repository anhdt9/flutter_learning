import 'package:flutter/material.dart';
import 'package:flutter_app_learning/core/viewmodel/view/login_view_model.dart';
import 'package:flutter_app_learning/ui/base_view.dart';
import 'package:flutter_app_learning/ui/route/local_route.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginViewModel>(
      onModelReady: (model) {},
      model: LoginViewModel(api: Provider.of(context)),
      builder: (context, model, _) => model.busy
          ? CircularProgressIndicator()
          : Container(
              padding: EdgeInsets.only(top: 50, left: 30, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  emailWidget(model),
                  passwordWidget(model),
                  loginWidget(model),
                  fbLoginWidget(model),
                ],
              ),
            ),
    );
  }

  Widget emailWidget(LoginViewModel model) {
    return StreamBuilder<String>(
        stream: model.email,
        builder: (context, snapshot) {
          print("email snapshot = ${snapshot.data}");
          return TextFormField(
            onChanged: model.changeEmail,
            decoration: InputDecoration(
              hintText: "abc@gmail.com",
              labelText: "Email",
              icon: Icon(Icons.email),
              errorText: snapshot.error,
            ),
          );
        });
  }

  Widget passwordWidget(LoginViewModel model) {
    return StreamBuilder<String>(
        stream: model.password,
        builder: (context, snapshot) {
          print("pass snapshot = ${snapshot.data}");
          return TextFormField(
            obscureText: true,
            onChanged: model.changePassword,
            decoration: InputDecoration(
              hintText: "123456",
              labelText: "Mat khau",
              icon: Icon(Icons.lock),
              errorText: snapshot.error,
            ),
          );
        });
  }

  Widget loginWidget(LoginViewModel model) {
    return StreamBuilder<bool>(
        stream: model.loginValid,
        builder: (context, snapshot) {
          return RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.blue,
            onPressed: snapshot.data == true
                ? () async {
                    var loginSuccess = await model.login("normal");
                    if (loginSuccess) {
                      Navigator.pushReplacementNamed(context, LocalRouter.HOME);
                    }
                  }
                : null,
            child: Text("Login"),
          );
        });
  }

  Widget fbLoginWidget(LoginViewModel model) {
    return SizedBox(
      width: 150,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "Login with Facebook",
          style: TextStyle(fontSize: 11),
        ),
        onPressed: () async {
          var loginSuccess = await model.login("facebook");
          if (loginSuccess) {
            Navigator.pushReplacementNamed(context, LocalRouter.HOME);
          }
        },
        color: Colors.blue,
        textColor: Colors.white,
      ),
    );
  }
}