import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:luno/play/uno_world.dart';

class Game extends StatelessWidget {
  const Game({super.key});
  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: FlameGame(world: UnoWorld()),
      backgroundBuilder: (context) {
        return Container(
          decoration: BoxDecoration(color: Colors.green),
          child: SizedBox.expand(),
        );
      },
    );
  }
}
