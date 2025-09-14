import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:luno/play/uno_world.dart';
import 'package:luno/state/table_game_manager.dart';

class Game extends StatelessWidget {
  Game(
    this.tgm,
    this.screenWidth,
    this.screenHeight,
    this.imagePath, {
    super.key,
  });

  double screenWidth;
  double screenHeight;
  String imagePath;
  TableGameManager tgm;

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: FlameGame(world: UnoWorld(tgm)),
      backgroundBuilder: (context) {
        return Stack(
          children: [
            Center(
              child: Image.asset(
                imagePath,
                width: screenWidth,
                height: screenHeight,
                fit: ((screenWidth / screenHeight) * 10).toInt() > 15
                    ? BoxFit.fitWidth
                    : BoxFit.fitHeight,
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(color: Colors.green),
                child: SizedBox(
                  width: screenWidth / 2,
                  height: screenHeight / 2,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
