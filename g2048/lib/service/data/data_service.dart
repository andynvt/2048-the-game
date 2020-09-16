import 'dart:math';

import 'package:flutter/material.dart';
import 'package:g2048/model/model.dart';
import 'package:g2048/res/res.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service.dart';

class DataService extends ChangeNotifier {
  static final shared = DataService();

  int mode = 4;
  GameStatus status = GameStatus();
  List<List<BlockInfo>> data = [];

  DataService() {
    //TODO: getmode from sharedpre

    initGame();
  }

  void initGame() {
    var random = new Random(DateTime.now().millisecondsSinceEpoch);
    var gamesize = mode * mode;
    var block1 = random.nextInt(gamesize);
    var block2 = random.nextInt(gamesize);

    while (block1 == block2) {
      block2 = random.nextInt(gamesize);
    }

    var newdata = List<List<BlockInfo>>();

    for (var i = 0; i < mode; i++) {
      var row = List<BlockInfo>();
      for (var j = 0; j < mode; j++) {
        var current = i * mode + j;
        row.add(BlockInfo(value: current == block1 || current == block2 ? 2 : 0, current: current));
      }
      newdata.add(row);
    }

    data.clear();
    data.addAll(newdata);
    notifyListeners();
  }

  double blockWidth() {
    return CS.getBlockWidth(mode);
  }

  double borderWidth() {
    return CS.getBorderWidth(mode);
  }

  BlockInfo getBlock(int i, int j, {List<List<BlockInfo>> data}) {
    if (data != null) {
      return data[i][j];
    }
    return this.data[i][j];
  }

  void update() {
    // 获取空格数, 将上一次的所有格子设成旧的
    int count = 0;
    for (var i = 0; i < mode; i++) {
      for (var j = 0; j < mode; j++) {
        var block = getBlock(i, j);
        block.isNew = false;
        if (block.value == 0) {
          count++;
        }
      }
    }

    // 有空格
    if (count > 0) {
      // 生成新的数字
      var random = new Random(DateTime.now().millisecondsSinceEpoch);
      var newpos = getBlankPosition(random.nextInt(count));

      var newblock = getBlock(newpos ~/ mode, newpos % mode);
      newblock.value = (random.nextInt(2) + 1) * 2;
      newblock.before = newblock.current = newpos;
      newblock.isNew = true;
      newblock.needCombine = newblock.needMove = false;
    }

    // 检测
    status.end = false;
    if (count <= 1) {
      status.end = isEnd();
    }
    notifyListeners();
  }

  bool isEnd() {
    int i, j;
    for (i = 0; i < mode; i++) {
      for (j = 0; j < mode - 1; j++) {
        if (data[i][j].value == data[i][j + 1].value) {
          return false;
        }
      }
    }

    for (j = 0; j < mode; j++) {
      for (i = 0; i < mode - 1; i++) {
        if (data[i][j].value == data[i + 1][j].value) {
          return false;
        }
      }
    }
    return true;
  }

  int getBlankPosition(int blank) {
    var index = 0;
    for (int i = 0; i < mode; i++) {
      for (int j = 0; j < mode; j++) {
        if (getBlock(i, j).value == 0) {
          if (index == blank) {
            return i * mode + j;
          } else {
            index++;
          }
        }
      }
    }
    return -1;
  }

  void swapBlock(int block1, int block2) {
    data[block1 ~/ mode][block1 % mode].current = block2;
    data[block1 ~/ mode][block1 % mode].before = block1;
    data[block2 ~/ mode][block2 % mode].current = block1;
    data[block2 ~/ mode][block2 % mode].before = block2;
    var temp = data[block1 ~/ mode][block1 % mode];
    data[block1 ~/ mode][block1 % mode] = data[block2 ~/ mode][block2 % mode];
    data[block2 ~/ mode][block2 % mode] = temp;
    notifyListeners();
  }

  DataService clone() {
    return this;

    // var newdata = List<List<BlockInfo>>();
    // for (var i = 0; i < mode; i++) {
    //   var row = List<BlockInfo>();
    //   for (var j = 0; j < mode; j++) {
    //     row.add(BlockInfo(
    //       current: data[i][j].current,
    //       value: data[i][j].value,
    //       isNew: false,
    //     ));
    //   }
    //   newdata.add(row);
    // }

    // (
    //   data: newdata,
    //   mode: this.mode,
    //   status: this.status == null
    //       ? null
    //       : GameStatus(
    //           adds: this.status.adds,
    //           end: this.status.end,
    //           moves: this.status.moves,
    //           scores: this.status.scores,
    //           total: this.status.total,
    //         ),
    // );
  }
  // static gameInit(GameState state, int mode) async {
  //   SharedPreferences refs = await SharedPreferences.getInstance();

  //   var key = 'total_' + mode.toString();
  //   if (state.status.total != null && state.status.scores > state.status.total) {
  //     refs.setInt(key, state.status.scores);
  //   }
  //   var state1 = GameState.initial(mode);

  //   state1.status = GameStatus(
  //     adds: 0,
  //     end: false,
  //     moves: 0,
  //     total: refs.getInt(key) ?? 0,
  //     scores: 0,
  //   );

  //   // store.dispatch(UpdateStateAction(state));
  // }
}
