import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:luno/play/card.dart';
import 'package:luno/play/player_box.dart';

class UnoWorld extends World {
  UnoWorld({super.key});

  @override
  FutureOr<void> onLoad() async {
    add(UnoCard(position: Vector2(0, 0)));
    add(PlayerPicture(PlayerSeat.left));
    add(PlayerPicture(PlayerSeat.top));
    add(PlayerPicture(PlayerSeat.right));
    add(PlayerPicture(PlayerSeat.mainSeat));
  }
}
