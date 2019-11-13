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
    _timer = new Timer.periodic(const Duration(seconds: 1), setTime);
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
    /*ClockDisplay(
      color: Colors.red,
      maxValue: 1000,
      getValue: (time) => time.millisecond,
    ),*/
    ClockDisplay(
      color: Colors.red,
      maxValue: 59,
      getValue: (time) => time.second,
    ),
    ClockDisplay(
      color: Colors.green,
      maxValue: 59,
      getValue: (time) => time.minute,
    ),
    ClockDisplay(
      color: Colors.blue,
      maxValue: 59,
      getValue: (time) => time.hour,
    ),
    ClockDisplay(
      color: Colors.yellow,
      maxValue: 31,
      getValue: (time) => time.day,
    ),
    ClockDisplay(
      color: Colors.cyan,
      maxValue: 12,
      getValue: (time) => time.month,
    ),
  ];

  ClockPainter(this.time, [this.bgColor = Colors.black]);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background
    Paint background = Paint()..color = bgColor;
    canvas.drawPaint(background);

    Offset center = size.center(Offset.zero);

    double trackSize = ((size.width) / (clocks.length + 1));

    for (var i = 0; i < clocks.length; i++) {
      ClockDisplay cd = clocks[i];
      double cdSize = trackSize * ((clocks.length - i));

      paintArc(canvas, center, cdSize, trackSize/2, cd.color,
          calcRadius(cd.getValue(time), cd.maxValue));
    }
  }

  double calcRadius(int value, int maxValue) {
    return ((value) / maxValue) * 360;
  }

  void paintArc(Canvas canvas, Offset center, double size, double width,
      Color color, double radius) {
    final wHalf = width / 2;

    Paint fill = Paint()..color = color;
    canvas.drawArc(
        Rect.fromCenter(
            center: center, width: size + wHalf, height: size + wHalf),
        vm.radians(-90),
        vm.radians(radius),
        true,
        fill);

    canvas.drawOval(
        Rect.fromCenter(
            center: center, width: size - wHalf, height: size - wHalf),
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
