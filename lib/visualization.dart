import 'package:flutter/cupertino.dart';

class ClockVisualizationSettings {
  final Color bgColor;

  ClockVisualizationSettings({
    this.bgColor,
  });
}

abstract class ClockVisualization {
  DateTime time;
  final ClockVisualizationSettings settings;

  ClockVisualization(this.settings);

  CustomPainter getCustomPainter();
}

class VisualizationSettings {
  final String name;
  final Duration refreshTime;

  VisualizationSettings({
    @required this.name,
    this.refreshTime = const Duration(milliseconds: 0),
  });
}

class Visualization {
  final VisualizationSettings settings;
  final ClockVisualization visualization;

  Visualization(this.settings, this.visualization);
}