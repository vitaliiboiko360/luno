import 'dart:async';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:luno/play/deck_cards.dart';
import 'package:luno/player_box/button_ready.dart';
import 'package:luno/player_box/player_seat.dart';
import 'package:luno/players_table/players_table.dart';
import 'package:luno/src/game.dart';
import 'package:luno/state/table_game_manager.dart';
import 'package:luno/state/table_state.dart';
import 'package:luno/ws/ws_send.dart';

class UnoWorld extends World {
  UnoWorld(this.tgm, {super.key});

  TableGameManager tgm;

  @override
  FutureOr<void> onLoad() async {
    // add(UnoCard(position: Vector2(0, 0)));
    add(PlayersTable());
    add(PlayerBoxNew(PlayerSeat.left));
    add(PlayerBoxNew(PlayerSeat.top));
    add(PlayerBoxNew(PlayerSeat.right));
    add(PlayerBoxNew(PlayerSeat.bottom));
    // add(ActiveHand());
    // add(MainPlayerBox());
    add(DeckCardsPositioned());
    add(ButtonReady());
    Future.delayed(Duration(seconds: 1), () {
      checkPlayerSeat();
      // (findGame() as Game).showPreGameOverlay();
    });
  }
}
