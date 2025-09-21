import 'package:flutter/material.dart';
import 'package:luno/src/game.dart';
import 'package:luno/state/table_game_manager.dart';

class App extends StatelessWidget {
  App(this.tgm, {super.key});

  TableGameManager tgm;

  @override
  Widget build(BuildContext context) {
    return UnoGame(tgm);
  }
}
