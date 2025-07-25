import 'dart:async';

import 'package:flame/components.dart';
import 'package:luno/play/playing_card.dart';

class ActiveHand extends Component {
  ActiveHand() : super();

  int numberOfCards = 0;

  @override
  FutureOr<void> onLoad() {
    add(PlayingCard(Vector2(-150, 0)));
    add(PlayingCard(Vector2(-100, 0)));
    add(PlayingCard(Vector2(-50, 0)));
    numberOfCards = 3;
    return super.onLoad();
  }

  addCard() {
    print('children.length before ${children.length}');
    add(PlayingCard(getCardPosition(numberOfCards)));
    print('children.length after ${children.length}');
  }

  playCard() {
    numberOfCards--;
  }

  rearangeCards() {
    int index = 0;
    children.forEach(
      (card) => (card as PositionComponent).position = getCardPosition(index++),
    );
  }
}

getCardPosition(int cardPosition) {
  if (cardPosition == 0) {
    return Vector2(-150, 0);
  }
  if (cardPosition == 1) {
    return Vector2(-100, 0);
  }
  if (cardPosition == 2) {
    return Vector2(-50, 0);
  }
  if (cardPosition == 3) {
    return Vector2(0, 0);
  }
  return Vector2(50, 0);
}
