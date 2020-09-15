import 'package:flutter/material.dart';
import 'package:flutter2048/actions/gameInit.dart';
import 'package:flutter2048/store/GameState.dart';
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
        reset: () {
          gameInit(store, store.state.mode);
        },
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
                        children: <Widget>[
                          Text(
                            'SCORE',
                            style: TextStyle(color: Color(0xffeee4da), fontWeight: FontWeight.bold),
                          ),
                          Text(
                            props.scores.toString(),
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                        children: <Widget>[
                          Text(
                            'BEST',
                            style: TextStyle(color: Color(0xffeee4da), fontWeight: FontWeight.bold),
                          ),
                          Text(
                            props.total.toString(),
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Join the numbers',
                      style: TextStyle(
                        color: Color(0xff776e65),
                        height: 1.2,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'and get to the ',
                        style: TextStyle(
                          color: Color(0xff776e65),
                        ),
                        children: [
                          TextSpan(
                            text: '2048 tile!',
                            style: TextStyle(
                              color: Color(0xff776e65),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                        onPressed: () {},
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
}

class ScoresProps {
  ScoresProps({this.mode, this.total, this.scores, this.isEnd, this.reset});

  int mode;
  int total;
  int scores;
  bool isEnd;
  Function reset;
}
