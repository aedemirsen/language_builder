import 'dart:convert';

import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:language_builder/src/language_model.dart';
import 'package:language_builder/src/local_database.dart';
import 'package:language_builder/src/restart_app.dart';

// ignore: must_be_immutable
class LanguageBuilder extends StatefulWidget {
  Widget child;
  Widget splash;
  String defaultLanguage;

  static String _currentLang;
  static Map<String, dynamic> texts;
  static Map<String, String> languages;
  Map<String, String> languagesMap;

  static LanguageBuilder lb = LanguageBuilder.x();

  /// If this option is true, then application's
  /// language will be set to device's selected language.
  bool useDeviceLanguage;

  LanguageBuilder.x({Key key}) : super(key: key);

  LanguageBuilder(
      {Key key,
      @required this.child,
      this.splash = const SizedBox.shrink(),
      @required this.defaultLanguage,
      this.useDeviceLanguage = false,
      @required this.languagesMap})
      : super(key: key) {
    LanguageBuilder.languages = languagesMap;
  }

  static changeLanguage(String lang, BuildContext context) async {
    await DatabaseOps.db.updateLang(lang);
    LanguageBuilder.lb._setLang(lang);
    RestartApp.restartApp(context);
  }

  _setLang(String lang) {
    LanguageBuilder._currentLang = lang;
    String _jsonStr = languages[lang];
    LanguageBuilder.texts = json.decode(_jsonStr);
  }

  static getCurrentLang() {
    return LanguageBuilder._currentLang;
  }

  //this method gives language by the language code.
  static getLangByCode(String code) {}

  static List<String> getAvailableLanguages() {
    return languages.keys.toList();
  }

  @override
  State<StatefulWidget> createState() {
    return _LanguageBuilderState();
  }
}

class _LanguageBuilderState extends State<LanguageBuilder> {
  @override
  Widget build(BuildContext context) {
    if (widget.useDeviceLanguage) {
      return FutureBuilder(
        future: Devicelocale.preferredLanguages,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List languages = snapshot.data;
            String _lang;
            //get device's currently preffered language, then set it for app.
            //if there is no config for that lang, the default is 'en'
            if (languages[0].toString().contains('-')) {
              //for iOS devices it is seperated by "-"
              _lang = languages[0].toString().split('-')[0];
            } else if (languages[0].toString().contains('_')) {
              //for android devices it is seperated by "_"
              _lang = languages[0].toString().split('_')[0];
            } else {
              _lang = widget.defaultLanguage;
            }
            widget._setLang(_lang);
            return widget.child;
          } else {
            return widget.splash;
          }
        },
      );
    } else {
      DatabaseOps.defaultLang = widget.defaultLanguage;
      return FutureBuilder(
        future: DatabaseOps.db.getLang(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Language _language = snapshot.data;
            var _lang = _language.lang;
            widget._setLang(_lang);
            return RestartApp(
              child: widget.child,
            );
          } else {
            return widget.splash;
          }
        },
      );
    }
  }
}
