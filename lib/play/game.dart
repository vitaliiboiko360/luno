import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:luno/bg/bg.dart';
import 'package:luno/play/uno_world.dart';
import 'dart:math';

import 'package:luno/src/overlays.dart';

class Game extends StatelessWidget {
  Game({super.key});
  String imagePath = images[Random().nextInt(images.length - 1)];
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return GameWidget(
      game: FlameGame(world: UnoWorld()),
      backgroundBuilder: buildBackground(imagePath, screenWidth, screenHeight),
      overlayBuilderMap: {
        'Anouncement': (BuildContext context, FlameGame game) => Anouncement(),
      },
      initialActiveOverlays: ['Anouncement'],
    );
  }
}
