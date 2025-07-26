import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:luno/play/playing_card.dart';

class ActiveHand extends Component {
  ActiveHand() : super(priority: -2);

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
    propagateToChildren((card) {
      (card as PositionComponent).position = getCardPosition(--index);
      (card as Component).priority = -(index + 10);
      (card as PlayingCard).setVisible();
      print('set card priority set ${card.priority}');
      return true;
    });
  }

  @override
  void onChildrenChanged(Component child, ChildrenChangeType type) {
    rearangeCards();
    super.onChildrenChanged(child, type);
  }
}

getCardPosition(int cardPosition) {
  double x = -(cardPosition - 1) * (30);
  return Vector2(x, 0);

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
