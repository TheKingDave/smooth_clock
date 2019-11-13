import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vm;

import 'package:flutter/cupertino.dart';

class Clock extends StatefulWidget {
  Clock({Key key}) : super(key: key);

  @override
  _ClockState createState() {
    return _ClockState();
  }
}

class _ClockState extends State<Clock> {
  Timer _timer;
  DateTime time;

  @override
  void initState() {
    super.initState();
    time = DateTime.now();
    _timer = new Timer.periodic(const Duration(milliseconds: 1), setTime);
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
    return CustomPaint(
      painter: ClockPainter(time),
      child: Container(),
    );
  }
}

class ClockPainter extends CustomPainter {
  final DateTime time;
  final Color bgColor;

  final List<ClockDisplay> clocks = [
    ClockDisplay(
      color: Colors.red,
      maxValue: 1000,
      getValue: (time) => time.millisecond,
    ),
    ClockDisplay(
      color: Colors.green,
      maxValue: 60,
      getValue: (time) => time.second,
    ),
    ClockDisplay(
      color: Colors.blue,
      maxValue: 60,
      getValue: (time) => time.minute,
    ),
  ];

  ClockPainter(this.time, [this.bgColor = Colors.black]);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background
    Paint background = Paint()..color = Colors.black;
    canvas.drawPaint(background);

    Offset center = size.center(Offset.zero);



    double msSize = (size.width / 3) * 2;
    paintArc(canvas, center, msSize, Color.fromARGB(255, 0, 255, 0),
        calcRadius(time.millisecond, 1000));

    double mSize = (size.width / 3);
    paintArc(canvas, center, mSize, Color.fromARGB(255, 255, 0, 0),
        calcRadius(time.second, 60));
  }

  double calcRadius(int value, int maxValue) {
    return ((value + 1) / maxValue) * 360;
  }

  void paintArc(
      Canvas canvas, Offset center, double size, Color color, double radius) {
    Paint fill = Paint()..color = color;
    canvas.drawArc(Rect.fromCenter(center: center, width: size, height: size),
        vm.radians(-90), vm.radians(radius), true, fill);

    canvas.drawOval(
        Rect.fromCenter(center: center, width: size - 20, height: size - 20),
        Paint()..color = this.bgColor);
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) {
    //return time.millisecond != oldDelegate.time.millisecond;
    return true;
  }
}

class ClockDisplay {
  Color color;
  int maxValue;
  int Function(DateTime time) getValue;

  ClockDisplay({this.color, this.maxValue, this.getValue});
}
