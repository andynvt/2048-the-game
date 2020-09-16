import 'package:flutter/material.dart';
import 'package:g2048/res/res.dart';
import 'package:g2048/service/service.dart';
import 'package:g2048/widget/widget.dart';

class Blocks extends StatefulWidget {
  @override
  _BlocksState createState() => _BlocksState();
}

class _BlocksState extends State<Blocks> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consum<DataService>(
      value: DataService.shared,
      builder: (_, service) {
        var blockFactory = BlockFactory(this, service.mode);
        blockFactory.play();

        return Container(
          width: CS.stageWidth,
          height: CS.stageWidth,
          padding: EdgeInsets.fromLTRB(
            CS.getBorderWidth(service.mode),
            CS.getBorderWidth(service.mode),
            0,
            0,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: getBlocks(blockFactory, service),
          ),
        );
      },
    );
  }

  List<Widget> getBlocks(BlockFactory blockFactory, DataService service) {
    var blocks = <Widget>[];
    service.data.forEach((row) {
      row.forEach((block) {
        if (block.value != 0) {
          blocks.add(blockFactory.create(block));
        }
      });
    });
    return blocks;
  }
}
