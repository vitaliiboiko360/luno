import 'package:flame/game.dart';
import 'package:luno/player_box/seat.dart';

Vector2 getPlayerPosition(PlayerSeat playerSeat) {
  if (playerSeat == PlayerSeat.left) {
    return Vector2(-250, -25);
  }
  if (playerSeat == PlayerSeat.top) {
    return Vector2(50, -350);
  }
  if (playerSeat == PlayerSeat.right) {
    return Vector2(250, -100);
  }
  return Vector2(75, 300);
}
