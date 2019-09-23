import 'package:base_flutter_app/blocs/login/bloc.dart';
import 'package:base_flutter_app/core/authorization/authorization_bloc.dart';
import 'package:base_flutter_app/core/authorization/authorization_state.dart';
import 'package:base_flutter_app/core/navigation_utils.dart';
import 'package:base_flutter_app/ui/screens/home_screen.dart';
import 'package:base_flutter_app/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthorizationBloc, AuthorizationState>(
        listener: (context, state) {
          if (state is AuthorizationUnauthenticatedState) {
            Future.delayed(Duration(seconds: 1), () {
              _navigateToLoginPage(context);
            });
          }

          if (state is AuthorizationAuthenticatedState) {
            _navigateToHomePage(context);
            Future.delayed(Duration(seconds: 1), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            });
          }
        },
        child: Scaffold(
          body: Container(
            child: Center(
              child: Text('Splash Screen'),
            ),
          ),
        ));
  }

  void _navigateToLoginPage(BuildContext context) {
    NavigationUtils.pushReplacement(context, [
      BlocProvider<LoginBloc>(builder: (context) => LoginBloc())
    ], LoginScreen());
  }

  void _navigateToHomePage(BuildContext context) {
    NavigationUtils.pushReplacement(context, [], HomeScreen());
  }
}
