import 'dart:async';
import 'dart:math';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:luno/play/active_hand.dart';
import 'package:luno/play/card.dart';
import 'package:luno/play/deck_cards.dart';
import 'package:luno/play/move_opp_card.dart';
import 'package:luno/play/player_box.dart';
import 'package:luno/player_box/button_take_seat.dart';
import 'package:luno/player_box/player_seat.dart';
import 'package:luno/state/table_game_manager.dart';

class UnoWorld extends World {
  UnoWorld(this.tgm, {super.key});

  TableGameManager tgm;

  @override
  FutureOr<void> onLoad() async {
    // add(UnoCard(position: Vector2(0, 0)));
    add(PlayerBoxNew(PlayerSeat.left));
    add(PlayerBox(PlayerSeat.top));
    add(PlayerBox(PlayerSeat.right));
    // add(ActiveHand());
    add(MainPlayerBox());
    add(DeckCardsPositioned());
    add(TakeSeatButton(tgm));
  }

  double deltaTime = 0;
  bool added = false;

  static const playerPositions = [
    PlayerSeat.left,
    PlayerSeat.top,
    PlayerSeat.right,
  ];

  @override
  void update(double dt) {
    // if (added == false) {
    //   deltaTime += dt;
    //   if (deltaTime > 4) {
    //     added = false;
    //     deltaTime = 0;
    //     add(
    //       MakeMove(
    //         getPlayerPosition(
    //           playerPositions[Random().nextInt(playerPositions.length)],
    //         ),
    //       ),
    //     );
    //   }
    // }
    super.update(dt);
  }
}
