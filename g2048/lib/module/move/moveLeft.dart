import 'package:g2048/model/model.dart';
import 'package:g2048/service/service.dart';

void moveLeft() {
  final state = DataService.shared;
  // if (state.status?.end == true) {
  //   state.initGame();
  //   return;
  // }
  final List<List<BlockInfo>> ls = List.from(state.data);
  int i, j, k;
  bool isMoved = false;
  bool haveMove = false;
  bool haveCombin = false;
  for (i = 0; i < state.mode; i++) {
    j = k = 0;

    while (j < state.mode && state.getBlock(i, j, data: ls).value == 0) j++;
    if (j > state.mode - 1) break;
    if (j > k) {
      isMoved = haveMove = true;
      var block = state.getBlock(i, j, data: ls);
      block.needMove = true;
      block.needCombine = false;
      state.swapBlock(i * state.mode + k, i * state.mode + j);
    }
    if (k > 0 &&
        state.getBlock(i, k, data: ls).value == state.getBlock(i, k - 1, data: ls).value &&
        state.getBlock(i, k - 1, data: ls).needCombine != true) {
      var currentBlock = state.getBlock(i, k, data: ls);
      var prevBlock = state.getBlock(i, k - 1, data: ls);
      prevBlock.before = isMoved ? currentBlock.before : (i * state.mode + k);
      prevBlock.current = i * state.mode + k - 1;
      prevBlock.needMove = true;
      prevBlock.needCombine = haveCombin = true;
      prevBlock.value <<= 1;
      state.status.scores += prevBlock.value;
      currentBlock.reset();
      currentBlock.current = currentBlock.before = i * state.mode + k;
    } else {
      k++;
    }
    j++;

    if (haveMove || haveCombin) {
      state.update();
    }
  }

  return;
  // var clonestate = state.clone();
  // int i, j, k;
  // bool isMoved = false;
  // bool haveMove = false;
  // bool haveCombin = false;
  // for (i = 0; i < clonestate.mode; i++) {
  //   j = k = 0;
  //   while (true) {
  //     while (j < clonestate.mode && clonestate.getBlock(i, j).value == 0) j++;
  //     if (j > clonestate.mode - 1) break;

  //     if (j > k) {
  //       isMoved = haveMove = true;
  //       var block = clonestate.getBlock(i, j);
  //       block.needMove = true;
  //       block.needCombine = false;
  //       clonestate.swapBlock(i * clonestate.mode + k, i * clonestate.mode + j);
  //     }

  //     if (k > 0 &&
  //         clonestate.getBlock(i, k).value == clonestate.getBlock(i, k - 1).value &&
  //         clonestate.getBlock(i, k - 1).needCombine != true) {
  //       var currentBlock = clonestate.getBlock(i, k);
  //       var prevBlock = clonestate.getBlock(i, k - 1);
  //       prevBlock.before = isMoved ? currentBlock.before : (i * clonestate.mode + k);
  //       prevBlock.current = i * clonestate.mode + k - 1;
  //       prevBlock.needMove = true;
  //       prevBlock.needCombine = haveCombin = true;
  //       prevBlock.value <<= 1;
  //       clonestate.status.scores += prevBlock.value;
  //       currentBlock.reset();
  //       currentBlock.current = currentBlock.before = i * clonestate.mode + k;
  //     } else {
  //       k++;
  //     }
  //     j++;
  //   }
  // }

  // if (haveMove || haveCombin) {
  //   clonestate.update();
  // }
  // return clonestate;
}
