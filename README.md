## Getting started

* This package is created to switch your app language among your defined language options easily.
* Your app will support every language you added to your custom Language class in language.dart.
* In the usage section you will find an explanation about Language class which you will need to create.

Shortly, this package switch the language of the app and restart it to make changes.

## Usage

It is very easy to use this package. Just wrap your root widget with LanguageBuilder.
LanguageBuilder needs some arguments. For usage:

```dart
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
        //splash: Container(),
      ),
    ),
  );
}
```
useDeviceLanguage --> If this parameter is true, then app is going to be use your phone's language.
                      if false, then you can switch among languages from your app. Like in the example section.

defaultLanguage   --> This String value should be the shortcut of the language you want it to be default.
                      And ofcourse that language config must be added to your custom Language class.

languagesMap      --> This is the part you will tell LanguageBuilder what languages and prepared texts 
                      it should use. 

child             --> This is your root widget.

splash            --> This widget can be used for splash screen if you have a splash to run at the startup.
                      By Default this is an empty widget. (this is optional)

Information About Language Class

In order to create your custom language configurations, you should create a dart file in your project path.
For example, create language.dart file and insert your configuration by using following format.

```dart
class Languages {
  static Map<String, String> languages = {
    "tr": """{
        "main_page": {
            "title": "Ana Sayfa",
            "second_page": "İkinci Sayfa"
        },
        "second_page": {
            "title": "İkinci Sayfa",
            "main_page": "Ana Sayfa",
            "message":"Bu sayfa 2. sayfadır."
        }
    }""",
    "en": """{
        "main_page": {
            "title": "Main Page",
            "second_page": "Second Page"
        },
        "second_page": {
            "title": "Second Page",
            "main_page": "Main Page",
            "message":"This is 2nd page."
        }
    }""",
    "de": """{
        "main_page": {
            "title": "Hauptseite",
            "second_page": "Zweite Seite"
        },
        "second_page": {
            "title": "Zweite Seite",
            "main_page": "Hauptseite",
            "message":"Dies ist die 2. Seite."
        }
    }"""
  };
}

```
We have 3 language option in that example above; Turkish(tr), English(en) and German(de).
This structure is basicaly a Map. [Key: Language code, Value: Json data for your pages texts]
LanguageBuilder parses that format for you and set your texts in the app.

Lets inspect this json data to understand the structure:
```dart
    "main_page": {
        "title": "Main Page",
        "second_page": "Second Page"
    },
    "second_page": {
        "title": "Second Page",
        "main_page": "Main Page",
        "message":"This is 2nd page."
    }
```

main_page is the page id for the screen that contains 'title and second_page' texts.
and title is the text id refers to "Main Page".
In the example above, we can assume the app has 2 pages. And 1st page have 2 texts, 2nd page have 3 texts.

Finally, lets take a look at the usage for Text() widgets. 

```dart
    //MainPage
    Scaffold(
      appBar: AppBar(
        title: Text(
            LanguageBuilder.texts['main_page']['title'],
        ),
      ),
    ),
```

In the example above, we placed a dynamic value to the Text() widget of AppBar title, so that the text can switch among the languages. But if you desire to simplfy this implementation, you can use the texts map like below:

```dart
    class MainPage extends StatelessWidget {

        Map<String, dynamic> _texts = {};

        @override
        Widget build(BuildContext context) {
            
            _texts = LanguageBuilder.texts['main_page'];
            
            return Scaffold(
                appBar: AppBar(
                    title: Text(_texts['title']),
                ),
            );

        }
```

Warning: to asignment of the _texts Map must be in the build widget.



## Additional information

You can get this package's source files, have a visit : 

https://github.com/aedemirsen/language_builder

Get the package:

https://pub.dev/packages/language_builder

Package is still being developed. Feel free to contribute. Please send me an email if you encounter any bugs or exceptions. 
