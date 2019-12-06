import 'dart:math';
import 'dart:ui';

import 'package:date_util/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vm;
import 'package:smoothclock/visualization.dart';

class SmoothClock extends ClockVisualization {
  SmoothClock(settings) : super(settings);

  @override
  CustomPainter getCustomPainter() {
    return _SmoothClockPainter(time, settings);
  }
}

class _SmoothClockPainter extends CustomPainter {
  final DateTime time;
  final ClockVisualizationSettings settings;
  _SmoothClockPainter(this.time, this.settings);

  final List<_ClockDisplay> clocks = [
    _ClockDisplay(
      color: Colors.red,
      maxValue: 59,
      getValue: (time) => time.second,
    ),
    _ClockDisplay(
      color: Colors.green,
      maxValue: 59,
      getValue: (time) => time.minute,
    ),
    _ClockDisplay(
      color: Colors.blue,
      maxValue: 24,
      getValue: (time) => time.hour,
    ),
    _ClockDisplay(
      color: Colors.yellow,
      maxValue: (DateTime time) =>
          DateUtil().daysInMonth(time.month, time.year),
      getValue: (time) => time.day,
    ),
    _ClockDisplay(
      color: Colors.cyan,
      maxValue: 12,
      getValue: (time) => time.month,
    ),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background
    Paint background = Paint()..color = settings.bgColor;
    canvas.drawPaint(background);

    Offset center = size.center(Offset.zero);

    double smallerSize = min(size.width, size.height);
    double trackSize = ((smallerSize) / (clocks.length + 1));

    for (var i = 0; i < clocks.length; i++) {
      _ClockDisplay cd = clocks[i];
      double cdSize = trackSize * ((clocks.length - i));

      paintArc(canvas, center, cdSize, trackSize / 2, cd.color,
          calcRadius(cd.getValue(time), cd.getMaxValue(time)));
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

    Paint reset = Paint()..color = settings.bgColor;

    canvas.drawOval(
        Rect.fromCenter(
            center: center, width: size - wHalf, height: size - wHalf),
        reset);
  }

  @override
  bool shouldRepaint(_SmoothClockPainter oldDelegate) {
    return time.second != oldDelegate.time.second;
  }
}

class _ClockDisplay {
  Color color;
  dynamic maxValue;
  int Function(DateTime time) getValue;

  _ClockDisplay({this.color, this.maxValue, this.getValue});

  int getMaxValue(DateTime time) {
    if (maxValue is Function) {
      return maxValue(time);
    }
    return maxValue;
  }
}
