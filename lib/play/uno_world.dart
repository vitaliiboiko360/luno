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

class UnoWorld extends World {
  UnoWorld({super.key});

  @override
  FutureOr<void> onLoad() async {
    // add(UnoCard(position: Vector2(0, 0)));
    add(PlayerBox(PlayerSeat.left));
    add(PlayerBox(PlayerSeat.top));
    add(PlayerBox(PlayerSeat.right));
    add(ActiveHand());
    add(MainPlayerBox());
    add(DeckCardsPositioned());
  }

  double deltaTime = 0;
  bool added = false;
  int playerIndex = 0;

  static const playerPositions = [
    PlayerSeat.left,
    PlayerSeat.top,
    PlayerSeat.right,
  ];

  @override
  void update(double dt) {
    if (added == false) {
      deltaTime += dt;
      if (deltaTime > 4) {
        added = false;
        deltaTime = 0;
        add(MakeMove(getPlayerPosition(playerPositions[playerIndex++])));
        if (playerIndex > 2) {
          playerIndex = 0;
        }
      }
    }
    super.update(dt);
  }
}
