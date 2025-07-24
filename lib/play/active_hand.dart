import 'dart:async';

import 'package:flame/components.dart';
import 'package:luno/play/playing_card.dart';

class ActiveHand extends PositionComponent {
  ActiveHand(Vector2 position)
    : super(anchor: Anchor.center, position: position);

  @override
  FutureOr<void> onLoad() {
    add(PlayingCard(Vector2(0, 0)));
    add(PlayingCard(Vector2(10, 0)));
    add(PlayingCard(Vector2(20, 0)));
    return super.onLoad();
  }
}
