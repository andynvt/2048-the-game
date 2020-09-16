import 'package:flutter/material.dart';
import 'package:g2048/module/move/moveDown.dart';
import 'package:g2048/module/move/moveLeft.dart';
import 'package:g2048/module/move/moveRight.dart';
import 'package:g2048/module/move/moveUp.dart';
import 'package:g2048/res/res.dart';

const pressTimeout = 200;
const dragLength = 300;

class Playground extends StatefulWidget {
  @override
  _PlaygroundState createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  int startTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: onDragStart,
      onHorizontalDragEnd: onHorizontalDragEnd,
      onVerticalDragStart: onDragStart,
      onVerticalDragEnd: onVerticalDragEnd,
      child: Container(
        color: Colors.transparent,
        height: CS.stageWidth,
      ),
    );
    // Container(
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(5),
    //                 color: Color.fromRGBO(255, 255, 255, 0.4)),
    //             height: Screen.stageWidth,
    //             child: Center(
    //               child: Text(
    //                 'Game Over',
    //                 style: TextStyle(
    //                   fontSize: 50,
    //                   color: Color(0xff776e65),
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //             ),
    //           )
  }

  void onDragStart(DragStartDetails evt) {
    startTime = DateTime.now().millisecondsSinceEpoch;
  }

  void onHorizontalDragEnd(DragEndDetails evt) {
    if (DateTime.now().millisecondsSinceEpoch - startTime > pressTimeout || evt.primaryVelocity.abs() < dragLength) return;
    if (evt.primaryVelocity > 0) {
      print('right');
      moveRight();
    } else {
      print('left');
      moveLeft();
    }
  }

  void onVerticalDragEnd(DragEndDetails evt) {
    if (DateTime.now().millisecondsSinceEpoch - startTime > pressTimeout || evt.primaryVelocity.abs() < dragLength) return;
    if (evt.primaryVelocity < 0) {
      moveUp();
    } else {
      moveDown();
    }
  }
}
