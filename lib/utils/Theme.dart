import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class TTheme extends ChangeNotifier {
  static final TTheme shared = TTheme();
  final Store<int> store = new Store<int>(_changeMode, initialState: 0);

  static ThemeData dark = ThemeData.dark();
  static ThemeData light = ThemeData.light();

  static int _changeMode(int mode, dynamic _) {
    mode += 1;
    if (mode > 2) {
      mode = 0;
    }
    return mode;
  }

  void changeMode() {
    store.dispatch(1);
  }

  ThemeData getTheme(int mode) {
    switch (mode) {
      case 0:
        return light;
      case 1:
        return dark;
      default:
        return light;
    }
  }
}
