import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_game_2048/config/config.dart';
import 'package:the_game_2048/service/data/data_service.dart';
import 'package:the_game_2048/widget/widget.dart';
import '../module.dart';

class GameView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GameViewState();
  }
}

class GameViewState extends State<GameView> {
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    newGame();
  }

  void newGame() {
    final service = DataService.shared();
    service.logic.init();
    service.setGameOver(isOver: false);
  }

  void moveLeft(DataService service) {
    service.logic.moveLeft();
    service.checkGameOver();
  }

  void moveRight(DataService service) {
    service.logic.moveRight();
    service.checkGameOver();
  }

  void moveUp(DataService service) {
    service.logic.moveUp();
    service.checkGameOver();
  }

  void moveDown(DataService service) {
    service.logic.moveDown();
    service.checkGameOver();
  }

  @override
  Widget build(BuildContext context) {
    return Consum<DataService>(
      value: DataService.shared(),
      builder: (_, service) {
        List<CellWidget> _cellWidgets = List<CellWidget>();
        for (int r = 0; r < service.row; ++r) {
          for (int c = 0; c < service.column; ++c) {
            _cellWidgets.add(
              CellWidget(cell: service.logic.get(r, c)),
            );
          }
        }
        List<Widget> children = List<Widget>();
        children.add(_buildGrid(service));
        children.addAll(_cellWidgets);
        return Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(0.0, 64.0, 0.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      color: Colors.orange[100],
                      child: Container(
                        width: 130.0,
                        height: 60.0,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "SCORE",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                service.score.toString(),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                          width: 130.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[400],
                            ),
                          ),
                          child: Center(
                            child: Text("NEW GAME"),
                          )),
                      onPressed: () {
                        newGame();
                      },
                    ),
                  ],
                )),
            Container(
              height: 50.0,
              child: Opacity(
                opacity: service.isGameOver ? 1.0 : 0.0,
                child: Center(
                  child: Text(
                    "Game Over!",
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ),
            Container(
                margin: Config.gameMargin,
                width: Config.boardSize(context).width,
                height: Config.boardSize(context).width,
                child: GestureDetector(
                  onVerticalDragUpdate: (detail) {
                    if (detail.delta.distance == 0 || _isDragging) {
                      return;
                    }
                    _isDragging = true;
                    if (detail.delta.direction > 0) {
                      moveDown(service);
                    } else {
                      moveUp(service);
                    }
                  },
                  onVerticalDragEnd: (detail) {
                    _isDragging = false;
                  },
                  onVerticalDragCancel: () {
                    _isDragging = false;
                  },
                  onHorizontalDragUpdate: (detail) {
                    if (detail.delta.distance == 0 || _isDragging) {
                      return;
                    }
                    _isDragging = true;
                    if (detail.delta.direction > 0) {
                      moveLeft(service);
                    } else {
                      moveRight(service);
                    }
                  },
                  onHorizontalDragDown: (detail) {
                    _isDragging = false;
                  },
                  onHorizontalDragCancel: () {
                    _isDragging = false;
                  },
                  child: Stack(
                    children: children,
                  ),
                )),
          ],
        );
      },
    );
  }

  Widget _buildGrid(DataService service) {
    final boardSize = Config.boardSize(context);
    double width = (boardSize.width - (service.column + 1) * Config.cellPadding) / service.column;
    List<CellBox> _backgroundBox = List<CellBox>();
    for (int r = 0; r < service.row; ++r) {
      for (int c = 0; c < service.column; ++c) {
        CellBox box = CellBox(
          left: c * width + Config.cellPadding * (c + 1),
          top: r * width + Config.cellPadding * (r + 1),
          size: width,
          color: Colors.grey[300],
        );
        _backgroundBox.add(box);
      }
    }
    return Positioned(
      left: 0.0,
      top: 0.0,
      child: Container(
        width: Config.boardSize(context).width,
        height: Config.boardSize(context).height,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Stack(
          children: _backgroundBox,
        ),
      ),
    );
  }
}

class AnimatedCellWidget extends AnimatedWidget {
  final BoardCell cell;
  AnimatedCellWidget({Key key, this.cell, Animation<double> animation}) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Consum<DataService>(
      value: DataService.shared(),
      builder: (_, service) {
        final Animation<double> animation = listenable;
        double animationValue = animation.value;
        Size boardSize = Config.boardSize(context);
        double width = (boardSize.width - (service.column + 1) * Config.cellPadding) / service.column;
        if (cell.number == 0) {
          return Container();
        } else {
          return CellBox(
            left: (cell.column * width + Config.cellPadding * (cell.column + 1)) + width / 2 * (1 - animationValue),
            top: cell.row * width + Config.cellPadding * (cell.row + 1) + width / 2 * (1 - animationValue),
            size: width * animationValue,
            color: Config.boxColors.containsKey(cell.number)
                ? Config.boxColors[cell.number]
                : Config.boxColors[Config.boxColors.keys.last],
            text: Text(
              cell.number.toString(),
              maxLines: 1,
              style: TextStyle(
                fontSize: 30.0 * animationValue,
                fontWeight: FontWeight.bold,
                color: cell.number < 32 ? Colors.grey[600] : Colors.grey[50],
              ),
            ),
          );
        }
      },
    );
  }
}

class CellWidget extends StatefulWidget {
  final BoardCell cell;
  // final GameViewState state;
  CellWidget({this.cell});
  _CellWidgetState createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(
        milliseconds: 200,
      ),
      vsync: this,
    );
    animation = new Tween(begin: 0.0, end: 1.0).animate(controller);
  }

  dispose() {
    controller.dispose();
    super.dispose();
    widget.cell.isNew = false;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cell.isNew && !widget.cell.isEmpty()) {
      controller.reset();
      controller.forward();
      widget.cell.isNew = false;
    } else {
      controller.animateTo(1.0);
    }
    return AnimatedCellWidget(
      cell: widget.cell,
      // state: widget.state,
      animation: animation,
    );
  }
}

class CellBox extends StatelessWidget {
  final double left;
  final double top;
  final double size;
  final Color color;
  final Text text;
  CellBox({this.left, this.top, this.size, this.color, this.text});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
          width: size,
          height: size,
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Center(child: FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.center, child: text))),
    );
  }
}
