import 'dart:async';

import 'package:flame/components.dart';
import 'package:luno/play/playing_card.dart';

class ActiveHand extends Component {
  ActiveHand() : super();

  @override
  FutureOr<void> onLoad() {
    add(PlayingCard(Vector2(-150, 0)));
    add(PlayingCard(Vector2(-100, 0)));
    add(PlayingCard(Vector2(-50, 0)));
    return super.onLoad();
  }
}
