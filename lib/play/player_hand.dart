import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';

const width = 246;
const height = 362;
const scale = 0.42;

class UnoCardHand extends SvgComponent {
  UnoCardHand(Vector2 position)
    : super(
        scale: Vector2.all(1),
        anchor: Anchor.center,
        size: Vector2(width / 10 * 3, height / 10 * 3),
        position: position,
      );

  @override
  Future<void> onLoad() async {
    svg = await Svg.load('cards/UNO_black_background_card_back.svg');
  }
}

class PlayerHand extends PositionComponent {
  PlayerHand() : super(anchor: Anchor.center, position: Vector2(30, 145));

  @override
  FutureOr<void> onLoad() {
    add(UnoCardHand(Vector2(60, 0)));
    add(UnoCardHand(Vector2(50, 0)));
    add(UnoCardHand(Vector2(40, 0)));
    add(UnoCardHand(Vector2(30, 0)));
    add(UnoCardHand(Vector2(20, 0)));
    add(UnoCardHand(Vector2(10, 0)));
    add(UnoCardHand(Vector2(0, 0)));
    return super.onLoad();
  }
}

class PlayerHandRight extends PositionComponent {
  PlayerHandRight() : super(anchor: Anchor.center, position: Vector2(30, 145));

  @override
  FutureOr<void> onLoad() {
    add(UnoCardHand(Vector2(0, 0)));
    add(UnoCardHand(Vector2(10, 0)));
    add(UnoCardHand(Vector2(20, 0)));
    add(UnoCardHand(Vector2(30, 0)));
    add(UnoCardHand(Vector2(40, 0)));
    add(UnoCardHand(Vector2(50, 0)));
    add(UnoCardHand(Vector2(60, 0)));
    return super.onLoad();
  }
}
