import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:g2048/model/model.dart';
import 'package:g2048/service/service.dart';

class HeadingScores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '2048',
              style: TextStyle(
                fontSize: 50,
                color: Color(0xff776e65),
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xffbbada0),
                    border: Border.all(color: Colors.transparent, width: 0),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'SCORE',
                        style: TextStyle(color: Color(0xffeee4da), fontWeight: FontWeight.bold),
                      ),
                      Text(
                        // props.scores.toString(),
                        '0000000',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xffbbada0),
                    border: Border.all(color: Colors.transparent, width: 0),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'BEST',
                        style: TextStyle(color: Color(0xffeee4da), fontWeight: FontWeight.bold),
                      ),
                      Text(
                        // props.total.toString(),
                        '00000',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    'Join and get to the',
                    maxLines: 2,
                    // textAlign: TextAlign.le,
                    style: TextStyle(
                      height: 1.2,
                    ),
                  ),
                  Text(
                    '2048 tile!',
                    style: TextStyle(
                      color: Color(0xff776e65),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 100,
                  child: FlatButton(
                    color: Color(0xff8f7a66),
                    textColor: Colors.white,
                    onPressed: () {
                      DataService.shared.initGame();
                    },
                    padding: EdgeInsets.zero,
                    child: Text(
                      'New Game',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                SizedBox(
                  width: 100,
                  child: FlatButton(
                    color: Color(0xff8f7a66),
                    textColor: Colors.white,
                    onPressed: () {},
                    //  => _settingClick(context, props),
                    child: Text(
                      'Setting',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void _settingClick(BuildContext context, ScoresProps props) {
    final w = MediaQuery.of(context).size.width;
    final width = (w - 64) / 3;
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 45,
                            height: 45,
                            child: FlatButton(
                              padding: EdgeInsets.zero,
                              child: Icon(Icons.info_outline),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              onPressed: () {},
                              //  => _infoClick(_, context),
                            ),
                          ),
                          SizedBox(width: 8),
                          SizedBox(
                            width: 45,
                            height: 45,
                            child: FlatButton(
                              padding: EdgeInsets.zero,
                              child: Icon(Icons.help_outline),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              onPressed: () {},
                              //  => _helpClick(_, context),
                            ),
                          ),
                        ],
                      ),
                      OutlineButton(
                        child: Text('Light theme'),
                        highlightedBorderColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        onPressed: () {
                          // TTheme.shared.changeMode();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(_).pop();
                              props.onChange(3);
                            },
                            child: Container(
                              color: Colors.red,
                              height: width,
                              width: width,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('3 x 3')
                        ],
                      ),
                      SizedBox(width: 16),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(_).pop();
                              props.onChange(4);
                            },
                            child: Container(
                              color: Colors.red,
                              height: width,
                              width: width,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('4 x 4')
                        ],
                      ),
                      SizedBox(width: 16),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(_).pop();
                              props.onChange(5);
                            },
                            child: Container(
                              color: Colors.red,
                              height: width,
                              width: width,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('5 x 5')
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
