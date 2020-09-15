import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CS {
  CS._();

  static double borderMargin = 10;
  static double spacerUnit = 2.5;
  static String version = 'v1.0.0';
  static String about =
      'Use your arrow keys to move the tiles. When two tiles with the same number touch, they merge into one!,';
  static String howToPlay =
      'Swipe up/down/left/right to move the tiles. When two tiles with the same number touch, they merge into one!';

  static double getBorderWidth(int gameType) {
    return spacerUnit / gameType * borderMargin;
  }

  static double getBlockWidth(int gameType) {
    return (stageWidth - getBorderWidth(gameType) * (gameType + 1)) / gameType;
  }

  static double get stageWidth => getWidth() - borderMargin * 2;


  static getRatio(int value) {
    int uiwidth = value is int ? value : 750;
    return ScreenUtil.mediaQueryData.size.width / uiwidth;
  }

  static getRpx(double value) {
    return value * getRatio(750);
  }

  static getBottomPadding() {
    return ScreenUtil.mediaQueryData.padding.bottom;
  }

  static getTopPadding() {
    return ScreenUtil.mediaQueryData.padding.top;
  }

  static getWidth() {
    return ScreenUtil.mediaQueryData.size.width;
  }

  static Platform platform = Platform();
}
