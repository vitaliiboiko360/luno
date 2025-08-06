import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
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

class UnoCardHand extends SvgComponent with HasVisibility {
  UnoCardHand(Vector2 position, this.cardPlace)
    : super(
        scale: Vector2.all(1),
        anchor: Anchor.center,
        size: Vector2(width / 10 * 2.75, height / 10 * 2.75),
        position: position,
      );

  CardPlace cardPlace;

  CardPlace get place => cardPlace;
  set place(CardPlace p) => cardPlace = p;

  getAngle(cardPlace) {
    if (cardPlace == CardPlace.left) {
      return 0.3;
    }
    if (cardPlace == CardPlace.beforeLeft) {
      return 0.2;
    }
    if (cardPlace == CardPlace.centerLeft) {
      return 0.1;
    }
    if (cardPlace == CardPlace.center) {
      return 0;
    }
    if (cardPlace == CardPlace.centerRight) {
      return -0.1;
    }
    if (cardPlace == CardPlace.beforeRight) {
      return -0.2;
    }
    if (cardPlace == CardPlace.right) {
      return -0.3;
    }
  }

  setCardAngle() {
    angle = getAngle(cardPlace);
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

  removeCardFromHand() {
    children.forEach((card) {
      if ((card as UnoCardHand).place == CardPlace.left) {
        card.isVisible = false;
        var ec1 = EffectController(duration: 0.2);
        var ec2 = EffectController(duration: 0.2);
        var newAngle = card.getAngle(CardPlace.right);
        card.addAll([
          MoveToEffect(Vector2(0, 7), ec1),
          RotateEffect.to(
            newAngle,
            ec2,
            onComplete: () {
              card.isVisible = true;
            },
          ),
        ]);
        card.place = CardPlace.right;
        card.priority = -1;
      }
      if ((card as UnoCardHand).place == CardPlace.beforeLeft) {
        var ec1 = EffectController(duration: 0.2);
        var ec2 = EffectController(duration: 0.2);
        var newAngle = card.getAngle(CardPlace.left);
        card.addAll([
          MoveToEffect(Vector2(60, 3), ec1),
          RotateEffect.to(newAngle, ec2),
        ]);
        card.place = CardPlace.left;
        card.priority = -8;
      }
      if ((card as UnoCardHand).place == CardPlace.centerLeft) {
        var ec1 = EffectController(duration: 0.2);
        var ec2 = EffectController(duration: 0.2);
        var newAngle = card.getAngle(CardPlace.beforeLeft);
        card.addAll([
          MoveToEffect(Vector2(50, 1), ec1),
          RotateEffect.to(newAngle, ec2),
        ]);
        card.place = CardPlace.beforeLeft;
        card.priority = -6;
      }
      if ((card as UnoCardHand).place == CardPlace.center) {
        var ec1 = EffectController(duration: 0.2);
        var ec2 = EffectController(duration: 0.2);
        var newAngle = card.getAngle(CardPlace.centerLeft);
        card.addAll([
          MoveToEffect(Vector2(40, 0), ec1),
          RotateEffect.to(newAngle, ec2),
        ]);
        card.place = CardPlace.centerLeft;
        card.priority = -5;
      }
      if ((card as UnoCardHand).place == CardPlace.centerRight) {
        var ec1 = EffectController(duration: 0.2);
        var ec2 = EffectController(duration: 0.2);
        var newAngle = card.getAngle(CardPlace.center);
        card.addAll([
          MoveToEffect(Vector2(30, 1), ec1),
          RotateEffect.to(newAngle, ec2),
        ]);
        card.place = CardPlace.center;
        card.priority = -4;
      }
      if ((card as UnoCardHand).place == CardPlace.beforeRight) {
        var ec1 = EffectController(duration: 0.2);
        var ec2 = EffectController(duration: 0.2);
        var newAngle = card.getAngle(CardPlace.centerRight);
        card.addAll([
          MoveToEffect(Vector2(20, 3), ec1),
          RotateEffect.to(newAngle, ec2),
        ]);
        card.place = CardPlace.centerRight;
        card.priority = -3;
      }
      if ((card as UnoCardHand).place == CardPlace.right) {
        var ec1 = EffectController(duration: 0.2);
        var ec2 = EffectController(duration: 0.2);
        var newAngle = card.getAngle(CardPlace.left);
        card.addAll([
          MoveToEffect(Vector2(60, 3), ec1),
          RotateEffect.to(newAngle, ec2),
        ]);
        card.place = CardPlace.left;
        card.priority = -2;
      }
    });
  }

  double timePassed = 0;

  // @override
  // void update(double dt) {
  //   timePassed += dt;
  //   if (timePassed > 6) {
  //     timePassed = 0;
  //     removeCardFromHand();
  //   }
  // }
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
