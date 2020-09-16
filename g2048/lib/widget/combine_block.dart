import 'package:flutter/material.dart';
import 'package:g2048/model/model.dart';
import 'package:g2048/module/module.dart';
import 'package:g2048/res/res.dart';
import 'package:g2048/service/service.dart';
import 'package:g2048/widget/widget.dart';

class CombinBlock extends BaseBlock {
  final BlockInfo info;
  final int mode;
  final AnimationController moveController;

  CombinBlock({
    Key key,
    this.info,
    this.mode,
    this.moveController,
    AnimationController combinController,
  }) : super(
          key: key,
          animation: Tween<double>(begin: 1, end: 1.25).animate(combinController),
        );

  @override
  Widget buildBlock(BuildContext context) {
    // Animation<double> animation = listenable;
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        MoveBlock(
          info: BlockInfo(
            isNew: false,
            value: info.value ~/ 2,
            before: info.before,
            current: info.current,
          ),
          mode: mode,
          controller: moveController,
        ),
        Consum<DataService>(
            value: DataService.shared,
            builder: (_, props) {
              return Positioned(
                top: (info.current ~/ props.mode) * (props.blockWidth() + props.borderWidth()),
                left: (info.current % props.mode) * (props.blockWidth() + props.borderWidth()),
                child: NumberText(value: this.info.value, size: props.blockWidth()),
                // Transform.scale(
                //   scale: animation.value,
                //   origin: Offset(0.5, 0.5),
                //   child: NumberText(value: this.info.value, size: props.blockWidth()),
                // ),
              );
            })
      ],
    );
  }
}
