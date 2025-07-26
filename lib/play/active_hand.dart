import 'dart:async';
import 'dart:core';

import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:luno/play/player_box.dart';
import 'package:luno/play/playing_card.dart';

class ActiveHand extends PositionComponent {
  ActiveHand()
    : super(priority: -1, position: Vector2(60, 225), anchor: Anchor.center);

  int numberOfCards = 0;

  @override
  FutureOr<void> onLoad() {
    add(PlayingCard(getCardPosition(0)));
    add(PlayingCard(getCardPosition(1)));
    add(PlayingCard(getCardPosition(2)));
    add(PlayingCard(getCardPosition(3)));
    add(PlayingCard(getCardPosition(4)));
    add(PlayingCard(getCardPosition(5)));
    add(PlayingCard(getCardPosition(6)));
    // add(PlayingCard(getCardPosition(7)));
    // add(PlayingCard(getCardPosition(8)));
    // add(PlayingCard(getCardPosition(9)));
    // add(PlayingCard(getCardPosition(10)));
    // add(PlayingCard(getCardPosition(11)));
    // add(PlayingCard(getCardPosition(12)));
    // add(PlayingCard(getCardPosition(13)));
    // add(PlayingCard(getCardPosition(14)));
    // add(PlayingCard(getCardPosition(15)));
    rearangeCards();
    numberOfCards = 3;
    return super.onLoad();
  }

  addCard() {
    print('children.length before ${children.length}');
    add(PlayingCard(getCardPosition(children.length), isVisible: false));
    print('children.length after ${children.length}');
  }

  playCard() {
    numberOfCards--;
  }

  rearangeCards() {
    int index = children.length;
    // propagateToChildren((card) {
    //   (card as PositionComponent).position = getCardPosition(--index);
    //   (card as Component).priority = -(index + 10);
    //   (card as PlayingCard).setVisible();
    //   print('set card priority set ${card.priority}');
    //   return true;
    // });
    children.forEach((card) {
      // var correctIndex = children.length > 15
      //     ? (--index) + (children.length - 15)
      //     : --index;
      var position = getCardPosition(--index);
      var diff = 60 + position[0];
      var angleY = getCardAngleAndY(diff.toInt());
      (card as PositionComponent).position = Vector2(position[0], angleY[1]);
      (card as PositionComponent).angle = angleY[0];
      (card as Component).priority = -(index + 10);
      (card as PlayingCard).setVisible();
      print('set card priority set ${card.priority}');
    });
  }

  @override
  void onChildrenChanged(Component child, ChildrenChangeType type) {
    rearangeCards();
    super.onChildrenChanged(child, type);
  }

  getCardPosition(int cardPosition) {
    var offset = (children.length / 2) - 2;
    double x = -(cardPosition - offset) * (30);
    return Vector2(x, 0);
  }
}

getCardAngleAndY(int xPosition) {
  var sign = xPosition > 0 ? 1 : -1;
  print('xpos = ${xPosition}');
  var abs = xPosition.abs();
  if (abs < 30) {
    return Vector2(0, -18);
  }
  if (abs < 60) {
    return Vector2(0.05 * (sign), -16);
  }
  if (abs < 90) {
    return Vector2(0.08 * (sign), -14);
  }
  if (abs < 120) {
    return Vector2(0.11 * (sign), -12);
  }
  if (abs < 150) {
    return Vector2(0.14 * (sign), -10);
  }
  return Vector2(0.17 * (sign), -8);
}

getCardAngleAndYSecondRow(int xPosition) {
  var position = getCardAngleAndY(xPosition);
  position[1] -= 25;
  return position;
}
