import 'dart:math';
import 'dart:ui';

import 'package:date_util/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vm;
import 'package:smoothclock/visualization.dart';

class BinaryClock extends ClockVisualization {
  BinaryClock(settings) : super(settings);

  @override
  CustomPainter getCustomPainter() {
    return _BinaryClockPainter(time, settings);
  }
}

class _BinaryClockPainter extends CustomPainter {
  final DateTime time;
  final ClockVisualizationSettings settings;

  _BinaryClockPainter(this.time, this.settings);

  @override
  void paint(Canvas canvas, Size size) {
    Paint background = Paint()..color = settings.bgColor;
    canvas.drawPaint(background);

    Offset center = size.center(Offset.zero);

    Orientation orientation =
        size.width < size.height ? Orientation.portrait : Orientation.landscape;

    double smallerSize = min(size.width, size.height);
    double radius =
        ((smallerSize) / (orientation == Orientation.portrait ? 19 : 13));

    Paint circleOn = Paint()..color = Color(0xff00ff00);
    Paint circleOff = Paint()..color = Color(0xff004000);

    const leds = [2, 4, 3, 4, 3, 4];
    final getters = [
      () => time.hour ~/ 10 % 10,
      () => time.hour % 10,
      () => time.minute ~/ 10 % 10,
      () => time.minute % 10,
      () => time.second ~/ 10 % 10,
      () => time.second % 10,
    ];

    double vCenter = center.dx - (radius * 9.5);
    double hCenter = center.dy - (radius * 4.5);

    for (int i = 0; i < 6; i++) {
      List<bool> states = toBinary(getters[i](), leds[i]);
      for (int a = 0; a < leds[i]; a++) {
        canvas.drawCircle(
            new Offset(vCenter + (radius * (2 + (i * 3))),
                hCenter + (radius * ((3 - a) * 3))),
            radius,
            states[a] ? circleOn : circleOff);
      }
    }

    /*
    canvas.drawLine(
        new Offset(0, center.dy), new Offset(size.width, center.dy), circleOn);
    canvas.drawLine(
        new Offset(center.dx, 0), new Offset(center.dx, size.height), circleOn);
     */
  }

  List<bool> toBinary(int number, int length) {
    List<bool> ret = List<bool>();
    for (int i = 0; i < length; i++) {
      int mask = 1 << i;
      ret.add((number & mask) != 0);
    }
    return ret;
  }

  @override
  bool shouldRepaint(_BinaryClockPainter oldDelegate) {
    return time.second != oldDelegate.time.second;
  }
}
