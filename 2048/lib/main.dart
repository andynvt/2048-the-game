import 'package:flutter/material.dart';
import 'game.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = '2048';
    return MaterialApp(
      title: appTitle,
      home: new Scaffold(
        body: GameWidget(
          row: 4,
          column: 4,
        ),
      ),
    );
  }
}
