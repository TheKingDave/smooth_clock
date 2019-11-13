import 'package:flutter/material.dart';

MaterialColor toSwatch(Color c) {
  Map<int, Color> colors = {
    50: Color.fromRGBO(c.red, c.green, c.blue, 0.1),
    100: Color.fromRGBO(c.red, c.green, c.blue, 0.2),
    200: Color.fromRGBO(c.red, c.green, c.blue, 0.3),
    300: Color.fromRGBO(c.red, c.green, c.blue, 0.4),
    400: Color.fromRGBO(c.red, c.green, c.blue, 0.5),
    500: Color.fromRGBO(c.red, c.green, c.blue, 0.6),
    600: Color.fromRGBO(c.red, c.green, c.blue, 0.7),
    700: Color.fromRGBO(c.red, c.green, c.blue, 0.8),
    800: Color.fromRGBO(c.red, c.green, c.blue, 0.9),
    900: Color.fromRGBO(c.red, c.green, c.blue, 1),
  };

  return MaterialColor(
    c.value,
    colors,
  );
}
