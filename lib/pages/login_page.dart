import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_learning/constants.dart';
import 'package:flutter_app_learning/local_route.dart';
import 'package:flutter_app_learning/services/api.dart';
import 'package:flutter_app_learning/viewmodels/LoginViewModel.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;

  @override
  void initState() {
    passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var loginViewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => LoginViewModel(api: Provider.of<Api>(context)),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 40, right: 40, top: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("images/1.jpg"),
                  ),
                ),
                Text(
                  "Hello",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Text(
                    "Welcome back",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                _emailWidget(loginViewModel),
                _passwordWidget(loginViewModel),
                _rememberWidget(loginViewModel),
                _loginBtnWidget(loginViewModel),
                _newUserForgotPasswordWidget(loginViewModel),
                _dividerWidget(),
                _fbGoogleLoginWidget(loginViewModel),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailWidget(LoginViewModel loginViewModel) {
    return StreamBuilder<String>(
        stream: loginViewModel.email.asBroadcastStream(),
        builder: (context, snapshot) {
          return TextFormField(
            onChanged: loginViewModel.changeEmail,
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter email",
              icon: Icon(Icons.email),
              errorText: snapshot.error,
            ),
          );
        });
  }

  Widget _passwordWidget(LoginViewModel loginViewModel) {
    return StreamBuilder<String>(
        stream: loginViewModel.password.asBroadcastStream(),
        builder: (context, snapshot) {
          return TextFormField(
            onChanged: loginViewModel.changePassword,
            obscureText: passwordVisible,
            decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter password",
                errorText: snapshot.error,
                icon: Icon(Icons.lock),
                suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    })),
          );
        });
  }

  Widget _rememberWidget(LoginViewModel loginViewModel) {
    return StreamBuilder<bool>(
        stream: loginViewModel.checked.asBroadcastStream(),
        builder: (context, snapshot) {
          return CheckboxListTile(
            title: Text(
              "Remember Me",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: loginViewModel.changeChecked,
            value: snapshot.data ?? false,
          );
        });
  }

  Widget _loginBtnWidget(LoginViewModel loginViewModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Center(
        child: StreamBuilder<bool>(
            stream: loginViewModel.loginValid.asBroadcastStream(),
            builder: (context, snapshot) {
              return SizedBox(
                width: 200,
                child: RaisedButton(
                  onPressed: snapshot.data == true
                      ? () async {
                          var loginSuccess =
                              await loginViewModel.login(LOGIN_TYPE.normal);
                          if (loginSuccess) {
                            Navigator.pushReplacementNamed(
                                context, LocalRouter.HOME);
                          }
                        }
                      : null,
                  color: Colors.blue,
                  splashColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget _newUserForgotPasswordWidget(LoginViewModel loginViewModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RichText(
            text: TextSpan(
                text: "NEW USER?",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
                children: [
                  TextSpan(
                    text: " SIGN UP",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("SIGN UP click!");
                      },
                  )
                ]),
          ),
          GestureDetector(
            onTap: () {
              print("FORGOT PASSWORD click!");
            },
            child: Text(
              "FORGOT PASSWORD?",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _dividerWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 15),
        child: Text(
          "----- Or Sign in with -----",
          style: TextStyle(color: Colors.black38, fontSize: 12),
        ),
      ),
    );
  }

  Widget _fbGoogleLoginWidget(LoginViewModel loginViewModel) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              var loginSuccess =
                  await loginViewModel.login(LOGIN_TYPE.facebook);
              if (loginSuccess) {
                Navigator.pushReplacementNamed(context, LocalRouter.HOME);
              }
            },
            child: CircleAvatar(
              backgroundImage: AssetImage("images/facebook.png"),
              radius: 25,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              print("google click!");
            },
            child: CircleAvatar(
              backgroundImage: AssetImage("images/google.png"),
              radius: 25,
            ),
          ),
        ],
      ),
    );
  }
}
