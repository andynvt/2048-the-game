import 'package:flutter/material.dart';
import 'package:g2048/res/res.dart';
import 'package:g2048/service/service.dart';
import 'package:g2048/widget/widget.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Consum<DataService>(
        value: DataService.shared,
        builder: (_, service) {
          return Container(
            padding: EdgeInsets.fromLTRB(
              CS.getBorderWidth(service.mode),
              CS.getBorderWidth(service.mode),
              0,
              0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffbbada0),
              border: Border.all(color: Colors.transparent, width: 0),
              borderRadius: BorderRadius.circular(5),
            ),
            child: getGrid(service),
          );
        },
      ),
    );
  }

  Widget getGrid(DataService service) {
    var rows = <Widget>[];
    for (var i = 0; i < service.mode; i++) {
      var columns = <Widget>[];
      for (var j = 0; j < service.mode; j++) {
        columns.add(
          Container(
            width: CS.getBlockWidth(service.mode),
            height: CS.getBlockWidth(service.mode),
            decoration: BoxDecoration(
              color: Color.fromRGBO(238, 228, 218, 0.35),
              border: Border.all(color: Colors.transparent, width: 0),
              borderRadius: BorderRadius.circular(5),
            ),
            margin: EdgeInsets.fromLTRB(
              0,
              0,
              CS.getBorderWidth(service.mode),
              CS.getBorderWidth(service.mode),
            ),
          ),
        );
      }
      rows.add(
        Row(
          textDirection: TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: columns,
        ),
      );
    }
    return Column(
      children: rows,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }
}
