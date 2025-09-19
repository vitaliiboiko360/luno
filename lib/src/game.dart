import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:luno/bg/bg.dart';
import 'package:luno/play/uno_world.dart';
import 'package:luno/src/overlays.dart';
import 'package:luno/state/table_game_manager.dart';

class UnoGame extends StatelessWidget {
  UnoGame(
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
      game: Game(world: UnoWorld(tgm)),
      backgroundBuilder: buildBackground(imagePath, screenWidth, screenHeight),
      overlayBuilderMap: {
        'ReadyTable': (BuildContext context, FlameGame game) => ReadyTable(),
      },
    );
  }
}

Widget readyTable(BuildContext context, FlameGame game) {
  return Center(
    child: Column(
      children: [Text('Game Will Start When All Players Are Ready')],
    ),
  );
}

class Game extends FlameGame {
  Game({super.world}) {
    showPreGameOverlay();
  }

  void showPreGameOverlay() {
    overlays.add('ReadyTable');
  }

  void hidePreGameOverlay() {
    overlays.remove('ReadyTable');
  }
}
