import 'package:flutter/material.dart';
import 'package:smoothclock/toSwatch.dart';
import 'package:flutter/services.dart';
import 'package:smoothclock/visu/SmoothClock.dart';
import 'package:smoothclock/visualization.dart';

import 'clock.dart';

void main() {
  // Hide bottom navigation bar
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ClockVisualizationSettings vss = ClockVisualizationSettings(bgColor: Colors.black);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smooth Clock',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: toSwatch(Colors.black),
      ),
      home: HomePage(
        title: 'Smooth Clock',
        child: Clock(Visualization(
            VisualizationSettings(
                name: "Smooth", refreshTime: const Duration(milliseconds: 1)),
            SmoothClock(vss))),
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Smooth Clock"),
            ),
            ListTile(
              title: Text("Binary Clock"),
            ),
          ],
        ),
      ),
      body: child,
    );
  }
}
