import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smoothclock/visualization.dart';

class Clock extends StatefulWidget {
  final Visualization visualization;

  Clock(this.visualization, {Key key}) : super(key: key);

  @override
  _ClockState createState() {
    return _ClockState(visualization);
  }
}

class _ClockState extends State<Clock> {
  final Visualization visualization;

  Timer _timer;
  DateTime time;

  _ClockState(this.visualization);

  @override
  void initState() {
    super.initState();
    time = DateTime.now();
    _timer = new Timer.periodic(visualization.settings.refreshTime, setTime);
  }

  void setTime(Timer _) {
    setState(() {
      time = DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    visualization.visualization.time = time;
    return CustomPaint(
      painter: visualization.visualization.getCustomPainter(),
      child: Container(),
    );
  }
}
