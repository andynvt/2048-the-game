import 'package:flutter/material.dart';

class Config {
  Config._();

  static final boxColors = <int, Color>{
    2: Colors.orange[50],
    4: Colors.orange[100],
    8: Colors.orange[200],
    16: Colors.orange[300],
    32: Colors.orange[400],
    64: Colors.orange[500],
    128: Colors.orange[600],
    256: Colors.orange[700],
    512: Colors.orange[800],
    1024: Colors.orange[900],
  };
  static final EdgeInsets gameMargin = const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0);
  static double cellPadding = 5.0;

  static Size boardSize(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    num width = size.width - Config.gameMargin.left - Config.gameMargin.right;
    return Size(width, width);
  }
}
