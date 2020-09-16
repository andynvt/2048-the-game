import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g2048/module/module.dart';

class GameView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750)..init(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: HeadingScores(),
                  ),
                  Stack(
                    children: <Widget>[
                      Background(),
                      Blocks(),
                      Playground(),
                    ],
                  ),
                  // ModeSelector(),
                  Container(
                    height: 50,
                    color: Colors.grey,
                    child: Text('Ads'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
