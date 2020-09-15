class ScoresProps {
  ScoresProps({this.mode, this.total, this.scores, this.isEnd, this.reset, this.onChange});

  int mode;
  int total;
  int scores;
  bool isEnd;
  Function reset;
  Function onChange;
}
