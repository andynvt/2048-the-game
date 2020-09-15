import 'package:flutter/material.dart';
import 'package:g2048/model/model.dart';
import 'package:g2048/res/res.dart';
import 'package:g2048/service/data/data_service.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.fromLTRB(CS.getBorderWidth(GameState.mode), vm.borderWidth, 0, 0),
      padding: EdgeInsets.fromLTRB(CS.getBorderWidth(4), CS.getBorderWidth(4), 0, 0),
      decoration: BoxDecoration(
        color: const Color(0xffbbada0),
        border: Border.all(color: Colors.transparent, width: 0),
        borderRadius: BorderRadius.circular(5),
      ),
      // child: getGrid(vm),
    );
  }
  Widget getGrid(GameBgProps props) {
    var rows = <Widget>[];
    for (var i = 0; i < props.mode; i++) {
      var columns = <Widget>[];
      for (var j = 0; j < props.mode; j++) {
        columns.add(Container(
          width: props.blockWidth,
          height: props.blockWidth,
          decoration: BoxDecoration(
            color: Color.fromRGBO(238, 228, 218, 0.35),
            border: Border.all(color: Colors.transparent, width: 0),
            borderRadius: BorderRadius.circular(5),
          ),
          margin:
              EdgeInsets.fromLTRB(0, 0, props.borderWidth, props.borderWidth),
        ));
      }
      rows.add(Row(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: columns,
      ));
    }
    return Column(
      children: rows,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }
}
