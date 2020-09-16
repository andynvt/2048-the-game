import 'package:flutter/material.dart';
import 'package:the_game_2048/module/module.dart';

class DataService extends ChangeNotifier {
  static DataService _sInstance;

  GameLogic logic;

  int row;
  int column;
  int score = 0;
  bool isGameOver = false;

  DataService._() {
    initGame(4, 4);
  }

  factory DataService.shared() {
    if (_sInstance == null) {
      _sInstance = DataService._();
    }
    return _sInstance;
  }

  void initGame(int row, int column) {
    this.row = row;
    this.column = column;
    logic = GameLogic();
    logic.init();
    notifyListeners();
  }

  void setGameOver({bool isOver}) {
    if (isOver != null) {
      isGameOver = isOver;
      notifyListeners();
    } else {
      isGameOver = !isGameOver;
      notifyListeners();
    }
  }

  void checkGameOver() {
    if (logic.isGameOver()) {
      isGameOver = true;
      notifyListeners();
    }
  }

  void updateScore(int newScore) {
    if (newScore == 0) {
      score = 0;
    } else {
      score += newScore;
    }
    notifyListeners();
  }
}
