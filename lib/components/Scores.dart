import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter2048/actions/gameInit.dart';
import 'package:flutter2048/constants/Display.dart';
import 'package:flutter2048/store/GameState.dart';
import 'package:flutter2048/utils/Theme.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Scores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<GameState, ScoresProps>(
      converter: (store) => ScoresProps(
        scores: store.state.status.scores,
        total: store.state.status.total,
        isEnd: store.state.status.end,
        reset: () => gameInit(store, store.state.mode),
        onChange: (mode) => gameInit(store, mode),
      ),
      onDidChange: (props) {
        if (props.isEnd && props.scores > props.total) {
          SharedPreferences.getInstance().then((refs) {
            refs.setInt('total_' + props.mode.toString(), props.scores);
          });
        }
      },
      builder: (context, props) {
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
                      padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
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
                            props.scores.toString(),
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
                      padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
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
                            props.total.toString(),
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
                        onPressed: () => props.reset(),
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
                        onPressed: () => _settingClick(context, props),
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
      },
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
                              onPressed: () => _infoClick(_, context),
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
                              onPressed: () => _helpClick(_, context),
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
                          TTheme.shared.changeMode();
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

  void _infoClick(BuildContext bottom, BuildContext context) {
    Navigator.of(bottom).pop();
    showDialog(
      context: context,
      builder: (__) {
        return AlertDialog(
          title: Text(
            'About',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(Display.about),
              SizedBox(height: 16),
              Text(
                '2048 The Game ${Display.version}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _helpClick(BuildContext bottom, BuildContext context) {
    Navigator.of(bottom).pop();
    showDialog(
      context: context,
      builder: (__) {
        return AlertDialog(
          title: Text(
            'How to play',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          content: Text(Display.howToPlay),
        );
      },
    );
  }
}

class ScoresProps {
  ScoresProps({this.mode, this.total, this.scores, this.isEnd, this.reset, this.onChange});

  int mode;
  int total;
  int scores;
  bool isEnd;
  Function reset;
  Function onChange;
}
