import 'package:flutter/material.dart';
import 'package:smoothclock/toSwatch.dart';
import 'package:flutter/services.dart';
import 'package:smoothclock/visu/BinaryClock.dart';
import 'package:smoothclock/visu/SmoothClock.dart';
import 'package:smoothclock/visualization.dart';

import 'clock.dart';

void main() {
  // Hide bottom navigation bar
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  static final ClockVisualizationSettings vss =
      ClockVisualizationSettings(bgColor: Colors.black);

  static final List<Visualization> visualizations = [
    Visualization(
        VisualizationSettings(
            name: "Smooth Clock",
            refreshTime: const Duration(milliseconds: 100)),
        SmoothClock(vss)),
    Visualization(
        VisualizationSettings(
            name: "Binary Clock",
            refreshTime: const Duration(milliseconds: 100)),
        BinaryClock(vss))
  ];

  Visualization selected;
  Key _key;

  @override
  void initState() {
    super.initState();
    selected = visualizations.first;
    _key = UniqueKey();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smooth Clock',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: toSwatch(Colors.black),
      ),
      home: HomePage(
          title: selected.settings.name,
          child: Clock(selected, key: _key),
          clocks: List.from(visualizations.map((v) => v.settings.name)),
          selected: selected.settings.name,
          onSelect: (name) {
            Visualization newSelect;
            for(var v in visualizations) {
              if(v.settings.name == name) {
                newSelect = v;
                break;
              }
            }
            if(newSelect != null && newSelect != selected) {
              setState(() {
                selected = newSelect;
                _key = UniqueKey();
              });
            }
          }),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;
  final Widget child;
  final List<String> clocks;
  final String selected;
  final Function(String name) onSelect;

  HomePage(
      {this.title,
      this.child,
      this.clocks,
      this.selected,
      this.onSelect,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      ListTile(
        title: Text("Clock Styles", style: TextStyle(fontSize: 20)),
      ),
      Divider(),
    ];

    children.addAll(clocks.map((name) => ListTile(
          title: Text(name),
          selected: this.selected == name,
          onTap: () => onSelect(name),
        )));

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: children,
        ),
      ),
      body: child,
    );
  }
}
