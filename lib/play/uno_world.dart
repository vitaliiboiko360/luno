import 'dart:async';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:luno/play/deck_cards.dart';
import 'package:luno/player_box/player_seat.dart';
import 'package:luno/state/table_game_manager.dart';
import 'package:luno/state/table_state.dart';
import 'package:luno/ws/ws_send.dart';

class UnoWorld extends World {
  UnoWorld(this.tgm, {super.key});

  TableGameManager tgm;

  @override
  FutureOr<void> onLoad() async {
    // add(UnoCard(position: Vector2(0, 0)));
    add(PlayerBoxNew(PlayerSeat.left));
    add(PlayerBoxNew(PlayerSeat.top));
    add(PlayerBoxNew(PlayerSeat.right));
    add(PlayerBoxNew(PlayerSeat.bottom));
    // add(ActiveHand());
    // add(MainPlayerBox());
    add(DeckCardsPositioned());

    Future.delayed(Duration(seconds: 3), () {
      checkPlayerSeat();
    });
  }
}
