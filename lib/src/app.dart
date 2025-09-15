import 'package:flutter/material.dart';
import 'package:luno/src/game.dart';
import 'package:luno/state/table_game_manager.dart';

class App extends StatelessWidget {
  App(this.tgm, this.imagePath, {super.key});

  TableGameManager tgm;
  String imagePath;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return UnoGame(tgm, screenWidth, screenHeight, imagePath);
  }
}
