import 'package:flutter/material.dart';

class LoginFormWidget extends StatelessWidget {

  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final bool isLoading;
  final Function onLogin;

  const LoginFormWidget({this.userNameController, this.passwordController, this.onLogin, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            controller: userNameController,
          ),
          TextField(
            controller: passwordController,
          ),
          isLoading ? Container(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator(),
          ) : RaisedButton(
            onPressed: () {
              onLogin();
            },
            child: Text("Login"),
          )
        ],
      ),
    );
  }
}
