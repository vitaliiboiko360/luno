import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:luno/play/uno_world.dart';
import 'package:luno/state/table_game_manager.dart';

class Game extends StatelessWidget {
  Game(this.tgm, {super.key});

  TableGameManager tgm;

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: FlameGame(world: UnoWorld(tgm)),
      backgroundBuilder: (context) {
        return Container(
          decoration: BoxDecoration(color: Colors.green),
          child: SizedBox.expand(),
        );
      },
    );
  }
}
