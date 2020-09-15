import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import './components/GameStage.dart';
import 'utils/Theme.dart';

void main() => runApp(GameApp());

class GameApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GameAppState();
}

class GameAppState extends State<GameApp> {
  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider.value(
    //   value: TTheme.shared,
    //   child: Consumer<TTheme>(
    //     builder: (_, theme, __) {
    //       return MaterialApp(
    //         // theme: ThemeData(
    //         //   fontFamily: 'SFPro',
    //         // ),
    //         theme: theme.getTheme(),
    //         home: Material(
    //           color: const Color(0xfffaf8ef),
    //           child: SafeArea(
    //             left: false,
    //             right: false,
    //             child: Stack(
    //               children: [
    //                 GameStage(),
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
    //     }
    //   ),
    // );
    return StoreProvider<int>(
      store: TTheme.shared.store,
      child: StoreConnector<int, dynamic>(
          converter: (store) => store.state,
          builder: (_, mode) {
            return MaterialApp(
              // theme: ThemeData(
              //   fontFamily: 'SFPro',
              // ),
              theme: TTheme.shared.getTheme(mode),
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
          }),
    );
  }
}
