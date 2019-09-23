import 'package:base_flutter_app/core/base_screen.dart';
import 'package:base_flutter_app/core/localization/bloc.dart';
import 'package:base_flutter_app/core/localization/localization.dart';
import 'package:base_flutter_app/core/theme/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends BaseState<SettingScreen> {

  @override
  Widget onBuild(BuildContext context) {
    final LocalizationBloc localizationBloc = BlocProvider.of<LocalizationBloc>(context);
    final ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).settingTitle),
      ),
      body: Container(
        alignment: AlignmentDirectional.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(AppLocalizations.of(context).languageLabel),
            ListTile(
              title: const Text('English'),
              leading: Radio(
                value: 'en',
                groupValue: localizationBloc.currentState.locale.languageCode,
                onChanged: (dynamic value) {
                  localizationBloc.dispatch(LocaleChangeEvent(locale: Locale('en')));
                }
              ),
            ),
            ListTile(
              title: const Text('Việt Nam'),
              leading: Radio(
                value: 'vi',
                groupValue: localizationBloc.currentState.locale.languageCode,
                onChanged: (dynamic value) {
                  localizationBloc.dispatch(LocaleChangeEvent(locale: Locale('vi')));
                },
              ),
            ),
            Text(AppLocalizations.of(context).themeLabel),
            ListTile(
              title: Text(AppLocalizations.of(context).light),
              leading: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
                return Radio(
                  value: LIGHT,
                  groupValue: themeBloc.currentState.themeType,
                  onChanged: (dynamic value) {
                    themeBloc.dispatch(ThemeChangedEvent(themeType: LIGHT));
                  },
                );
              })
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).dark),
              leading: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
                return Radio(
                  value: DARK,
                  groupValue: themeBloc.currentState.themeType,
                  onChanged: (dynamic value) {
                    themeBloc.dispatch(ThemeChangedEvent(themeType: DARK));
                  },
                );
              })
            ),
          ],
        ),
      )
    );
  }
}
