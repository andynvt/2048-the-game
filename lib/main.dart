import 'package:flutter/material.dart';
import './components/GameStage.dart';

void main() => runApp(GameApp());

class GameApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GameAppState();
}

class GameAppState extends State<GameApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'SFPro',
      ),
      home: Material(
        color: const Color(0xfffaf8ef),
        child: SafeArea(
          left: false,
          right: false,
          child: Stack(
            children: [
              GameStage(),
            ],
          ),
        ),
      ),
    );
  }
}
