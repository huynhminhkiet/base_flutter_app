import 'package:base_flutter_app/blocs/login/login_bloc.dart';
import 'package:base_flutter_app/blocs/login/login_event.dart';
import 'package:base_flutter_app/blocs/login/login_state.dart';
import 'package:base_flutter_app/core/localization/localization.dart';
import 'package:base_flutter_app/core/navigation_utils.dart';
import 'package:base_flutter_app/core/page/page_bloc.dart';
import 'package:base_flutter_app/ui/widgets/login_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/base_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget onBuild(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    loginBloc.pageBloc = BlocProvider.of<PageBloc>(context);

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          _navigateToHome(context);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).login),
            ),
            body: LoginFormWidget(
              userNameController: _usernameController,
              passwordController: _passwordController,
              isLoading: state is LoginLoadingState,
              onLogin: () {
                loginBloc.dispatch(LoginClickEvent(_usernameController.text, _passwordController.text));
//                BlocProvider.of<LocalizationBloc>(context).dispatch(LocaleChangeEvent(locale: Locale("vi")));
              },
            ),
          );
        },
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    NavigationUtils.pushReplacement(context, [], HomeScreen());
  }


}
