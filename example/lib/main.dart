// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_builder/language_builder.dart';
import 'languages.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Language Builder Example',
      home: LanguageBuilder(
        useDeviceLanguage: false,
        defaultLanguage: 'en',
        languagesMap: Languages.languages,
        child: MainPage(),
        splash: Container(),
      ),
    ),
  );
}

class MainPage extends StatelessWidget {
  //1st method
  //Define _texts here to reach from whole MainPage widget
  //But assigning must be done in the build method.(38th line)
  Map<String, dynamic> _texts = {};

  //2nd method
  //Or just use the LanguageBuilder's static field called 'texts'
  //Example --> LanguageBuilder.texts['main_page']['title'];
  //this example gives us the title text at the main_page.

  @override
  Widget build(BuildContext context) {
    //
    _texts = LanguageBuilder.texts['main_page'];
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageBuilder.texts['main_page']['title']),
      ),
      floatingActionButton: ElevatedButton(
        child: Text(LanguageBuilder.texts['main_page']['second_page']),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondPage()),
          );
        },
      ),
      body: Flex(
        direction: Axis.vertical,
        //we get the number of available language configs at our custom language.dart file.
        //for this example we have 3 language options. [turkish,english,german]
        children: LanguageBuilder.getAvailableLanguages().map((e) {
          return Column(
            children: [
              SizedBox(
                height: 50,
                child: TextButton(
                  onPressed: () {
                    //if click at the current language do nothing.
                    if (e != LanguageBuilder.getCurrentLang()) {
                      LanguageBuilder.changeLanguage(e, context);
                    }
                  },
                  child: Builder(
                    builder: (context) {
                      if (e == 'tr') {
                        return Text('Türkçe');
                      } else if (e == 'en') {
                        return Text('English');
                      } else if (e == 'de') {
                        return Text('Deutsch');
                      } else {
                        return Text('NULL');
                      }
                    },
                  ),
                ),
              ),
              Divider(
                height: 0,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageBuilder.texts['second_page']['title']),
      ),
      body: Center(
        child: Text(LanguageBuilder.texts['second_page']['message']),
      ),
      floatingActionButton: ElevatedButton(
        child: Text(LanguageBuilder.texts['second_page']['main_page']),
        onPressed: () {
          Navigator.pop(
            context,
          );
        },
      ),
    );
  }
}
