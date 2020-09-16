import 'package:flutter/material.dart';
import 'package:g2048/model/model.dart';
import 'package:g2048/module/module.dart';
import 'package:g2048/service/service.dart';
import 'package:g2048/widget/widget.dart';

double getBegin(BlockInfo info, int mode) {
  return (info.current % mode == info.before % mode
          ? info.before ~/ mode - info.current ~/ mode
          : info.before % mode - info.current % mode) *
      1.0;
}

class MoveBlock extends BaseBlock {
  final BlockInfo info;
  final int mode;

  MoveBlock({
    Key key,
    this.info,
    this.mode,
    AnimationController controller,
  }) : super(
          key: key,
          animation: Tween<double>(begin: getBegin(info, mode), end: 0).animate(controller),
        );

  @override
  Widget buildBlock(BuildContext context) {
    // Animation<double> animation = listenable;
    var direction = info.current % mode == info.before % mode ? 1 : 0;
    return Consum<DataService>(
        value: DataService.shared,
        builder: (_, props) {
          return Positioned(
            top: (info.current ~/ props.mode) * (props.blockWidth() + props.borderWidth()),
            left: (info.current % props.mode) * (props.blockWidth() + props.borderWidth()),
            child: NumberText(value: this.info.value, size: props.blockWidth()),
            // Transform.translate(
            //   offset: direction == 0
            //       ? Offset(animation.value * (props.blockWidth() + props.borderWidth()), 0)
            //       : Offset(0, animation.value * (props.blockWidth() + props.borderWidth())),
            //   child: NumberText(value: this.info.value, size: props.blockWidth()),
            // ),
          );
        });
  }
}

void getDirection(double current, double before) {}
