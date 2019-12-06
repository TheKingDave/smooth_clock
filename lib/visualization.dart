import 'package:flutter/cupertino.dart';

class ClockVisualizationSettings {
  final Color bgColor;

  ClockVisualizationSettings({
    this.bgColor,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClockVisualizationSettings &&
          runtimeType == other.runtimeType &&
          bgColor == other.bgColor;

  @override
  int get hashCode => bgColor.hashCode;
}

abstract class ClockVisualization {
  DateTime time;
  final ClockVisualizationSettings settings;

  ClockVisualization(this.settings);

  CustomPainter getCustomPainter();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClockVisualization &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          settings == other.settings;

  @override
  int get hashCode => time.hashCode ^ settings.hashCode;
}

class VisualizationSettings {
  final String name;
  final Duration refreshTime;

  VisualizationSettings({
    @required this.name,
    this.refreshTime = const Duration(milliseconds: 0),
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisualizationSettings &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          refreshTime == other.refreshTime;

  @override
  int get hashCode => name.hashCode ^ refreshTime.hashCode;
}

class Visualization {
  final VisualizationSettings settings;
  final ClockVisualization visualization;

  Visualization(this.settings, this.visualization);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Visualization &&
          runtimeType == other.runtimeType &&
          settings == other.settings &&
          visualization == other.visualization;

  @override
  int get hashCode => settings.hashCode ^ visualization.hashCode;
}