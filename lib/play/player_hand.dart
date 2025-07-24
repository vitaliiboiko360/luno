import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';

const width = 246;
const height = 362;
const scale = 0.42;

enum CardPlace {
  left,
  beforeLeft,
  centerLeft,
  center,
  centerRight,
  beforeRight,
  right,
}

class UnoCardHand extends SvgComponent {
  UnoCardHand(Vector2 position, this.cardPlace)
    : super(
        scale: Vector2.all(1),
        anchor: Anchor.center,
        size: Vector2(width / 10 * 2.75, height / 10 * 2.75),
        position: position,
      );

  CardPlace cardPlace;

  setCardAngle() {
    if (cardPlace == CardPlace.left) {
      angle = 0.3;
    }
    if (cardPlace == CardPlace.beforeLeft) {
      angle = 0.2;
    }
    if (cardPlace == CardPlace.centerLeft) {
      angle = 0.1;
    }
    if (cardPlace == CardPlace.center) {
      angle = 0;
    }
    if (cardPlace == CardPlace.centerRight) {
      angle = -0.1;
    }
    if (cardPlace == CardPlace.beforeRight) {
      angle = -0.2;
    }
    if (cardPlace == CardPlace.right) {
      angle = -0.3;
    }
  }

  @override
  Future<void> onLoad() async {
    svg = await Svg.load('cards/UNO_black_background_card_back.svg');
    setCardAngle();
  }
}

class UnoCardHandRight extends SvgComponent {
  UnoCardHandRight(Vector2 position, this.cardPlace)
    : super(
        scale: Vector2.all(1),
        anchor: Anchor.center,
        size: Vector2(width / 10 * 2.75, height / 10 * 2.75),
        position: position,
      );

  CardPlace cardPlace;

  setCardAngle() {
    if (cardPlace == CardPlace.left) {
      angle = 0.4;
    }
    if (cardPlace == CardPlace.beforeLeft) {
      angle = 0.3;
    }
    if (cardPlace == CardPlace.centerLeft) {
      angle = 0.2;
    }
    if (cardPlace == CardPlace.center) {
      angle = 0.1;
    }
    if (cardPlace == CardPlace.centerRight) {
      angle = 0;
    }
    if (cardPlace == CardPlace.beforeRight) {
      angle = -0.1;
    }
    if (cardPlace == CardPlace.right) {
      angle = -0.2;
    }
  }

  @override
  Future<void> onLoad() async {
    svg = await Svg.load('cards/UNO_black_background_card_back.svg');
    setCardAngle();
  }
}

class PlayerHand extends PositionComponent {
  PlayerHand() : super(anchor: Anchor.center, position: Vector2(30, 145));

  @override
  FutureOr<void> onLoad() {
    add(UnoCardHand(Vector2(60, 3), CardPlace.left));
    add(UnoCardHand(Vector2(50, 1), CardPlace.beforeLeft));
    add(UnoCardHand(Vector2(40, 0), CardPlace.centerLeft));
    add(UnoCardHand(Vector2(30, 1), CardPlace.center));
    add(UnoCardHand(Vector2(20, 3), CardPlace.centerRight));
    add(UnoCardHand(Vector2(10, 5), CardPlace.beforeRight));
    add(UnoCardHand(Vector2(0, 7), CardPlace.right));
    return super.onLoad();
  }
}

class PlayerHandRight extends PositionComponent {
  PlayerHandRight() : super(anchor: Anchor.center, position: Vector2(30, 145));

  @override
  FutureOr<void> onLoad() {
    add(UnoCardHand(Vector2(0, 5), CardPlace.right));
    add(UnoCardHand(Vector2(10, 3), CardPlace.beforeRight));
    add(UnoCardHand(Vector2(20, 1), CardPlace.centerRight));
    add(UnoCardHand(Vector2(30, 0), CardPlace.center));
    add(UnoCardHand(Vector2(40, 1), CardPlace.centerLeft));
    add(UnoCardHand(Vector2(50, 3), CardPlace.beforeLeft));
    add(UnoCardHand(Vector2(60, 5), CardPlace.left));
    return super.onLoad();
  }
}
