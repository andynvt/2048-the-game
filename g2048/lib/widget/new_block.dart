import 'package:flutter/material.dart';
import 'package:g2048/model/model.dart';
import 'package:g2048/module/module.dart';
import 'package:g2048/service/service.dart';
import 'package:g2048/widget/widget.dart';

class NewBlock extends BaseBlock {
  final BlockInfo info;

  NewBlock({
    Key key,
    this.info,
    AnimationController controller,
  }) : super(
          key: key,
          animation: new Tween<double>(begin: 0.1, end: 1.0).animate(controller),
        );

  @override
  Widget buildBlock(BuildContext context) {
    // Animation<double> animation = listenable;
    return Consum<DataService>(
      value: DataService.shared,
      builder: (_, props) {
        return Positioned(
          top: (info.current ~/ props.mode) * (props.blockWidth() + props.borderWidth()),
          left: (info.current % props.mode) * (props.blockWidth() + props.borderWidth()),
          child: NumberText(value: this.info.value, size: props.blockWidth()),
          //  Transform.scale(
          //   scale: animation.value,
          //   origin: Offset(0.5, 0.5),
          //   child: NumberText(value: this.info.value, size: props.blockWidth()),
          // ),
        );
      },
    );
  }
}
