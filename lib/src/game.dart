import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luno/bg/bg.dart';
import 'package:luno/play/uno_world.dart';
import 'package:luno/src/overlay_playerconfig.dart';
import 'package:luno/src/overlays.dart';
import 'package:luno/state/table_game_manager.dart';
import 'package:riverpod/riverpod.dart';

class UnoGame extends StatelessWidget {
  UnoGame(this.tgm, {super.key});

  TableGameManager tgm;

  @override
  Widget build(BuildContext context) {
    return GameWidget<Game>(
      game: Game(world: UnoWorld(tgm)),
      overlayBuilderMap: {
        'ReadyTable': (BuildContext context, Game game) => ReadyTable(),
        'Anouncement': (BuildContext context, Game game) => Anouncement(),
        'PlayerConfig': (BuildContext context, Game game) =>
            UncontrolledProviderScope(
              container: tgm.providerContainer,
              child: PlayerConfig(),
            ),
      },
      initialActiveOverlays: ['ReadyTable', 'PlayerConfig'],
    );
  }
}
//, 'ReadyTable'

class Game extends FlameGame {
  Game({super.world});

  @override
  Color backgroundColor() => const Color.fromARGB(0, 0, 0, 0);

  void showPreGameOverlay() {
    overlays.add('ReadyTable');
  }

  void hidePreGameOverlay() {
    overlays.remove('ReadyTable');
  }
}
