import 'package:base_flutter_app/core/page/page_bloc.dart';
import 'package:base_flutter_app/core/page/page_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }

  _build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PageBloc, PageState>(
          listener: (context, state) {

            if (state is SuccessState) {
              _showDialog(state.title, state.message);
            }

            if (state is ErrorState) {
              _showDialog(state.title, state.message);
            }

          },
        ),
      ],
      child: onBuild(context),
    );
  }

  Widget onBuild(BuildContext context);

  Future<void> _showDialog(String title, String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title == null ? null : Text(title),
          content: message == null ? null : Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
