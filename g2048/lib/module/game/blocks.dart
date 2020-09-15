import 'package:flutter/material.dart';
import 'package:g2048/model/model.dart';
import 'package:g2048/res/res.dart';
import 'package:g2048/service/service.dart';

class Blocks extends StatefulWidget  {
  @override
  _BlocksState createState() => _BlocksState();
}

class _BlocksState extends State<Blocks> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var blockFactory = BlockFactory(this, 4);
        blockFactory.play();
    return Container(
      width: CS.stageWidth,
      height: CS.stageWidth,
      padding: EdgeInsets.fromLTRB(CS.getBorderWidth(4), CS.getBorderWidth(4), 0, 0),
      // child: Stack(
      //   fit: StackFit.expand,
      //   children: getBlocks(blockFactory, props),
      // ),
    );
  }

  List<Widget> getBlocks(BlockFactory blockFactory, BlocksProps props) {
    var blocks = <Widget>[];
    props.data.forEach((row) {
      row.forEach((block) {
        if (block.value != 0) {
          blocks.add(blockFactory.create(block));
        }
      });
    });
    return blocks;
  }
}

class BlocksProps {
  int mode;
  double padding;
  List<List<BlockInfo>> data;

  BlocksProps({this.padding, this.mode, this.data});
}

