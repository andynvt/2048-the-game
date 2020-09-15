import 'package:flutter/material.dart';
import 'package:g2048/service/service.dart';
import 'module/module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheService.init();
  runApp(G2048());
}

class G2048 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameView(),
    );
  }
}
