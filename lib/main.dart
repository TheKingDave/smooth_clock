import 'package:flutter/material.dart';
import 'package:smoothclock/toSwatch.dart';

import 'clock.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smooth Clock',
      theme: ThemeData(
        primarySwatch: toSwatch(Colors.black),
      ),
      home: HomePage(
        title: 'Smooth Clock',
        child: Clock(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;
  final Widget child;

  HomePage({this.title, this.child, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: child,
    );
  }
}
