import 'package:flutter/material.dart';

abstract class BaseBlock extends Container {
  BaseBlock({Key key, Animation animation})
      : super(
          key: key,
          // listenable: animation,
        );

  @override
  Widget build(BuildContext context) {
    return buildBlock(context);
    // return StoreConnector<GameState, BlockProps>(
    //   converter: (store) => BlockProps(
    //         blockWidth: Screen.getBlockWidth(store.state.mode),
    //         borderWidth: Screen.getBorderWidth(store.state.mode),
    //         mode: store.state.mode,
    //       ),
    //   builder: buildBlock,
    // );
  }

  @protected
  Widget buildBlock(BuildContext context);
}

// class BlockProps {
//   double blockWidth;
//   double borderWidth;
//   int mode;

//   BlockProps({this.blockWidth, this.borderWidth, this.mode});
// }
