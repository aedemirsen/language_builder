import 'package:flutter/material.dart';

class RestartApp extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const RestartApp({@required this.child, this.arg});

  final Widget child;
  final dynamic arg;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartAppState>().restartApp();
  }

  @override
  _RestartAppState createState() => _RestartAppState();
}

class _RestartAppState extends State<RestartApp> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
