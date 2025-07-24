import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/geometry.dart';
import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:luno/play/cards.dart';

const double width = 246;
const double height = 362;
const scale = 0.42;

class OpenCard extends SvgComponent {
  OpenCard(position)
    : super(
        size: Vector2(width, height),
        anchor: Anchor.center,
        scale: Vector2(scale, scale),
        position: position,
      );

  @override
  Future<void> onLoad() async {
    svg = await Svg.load('cards/${getRandomCardPath()}');
  }
}

class PlayingCard extends PositionComponent with TapCallbacks {
  PlayingCard(Vector2 position)
    : super(
        size: Vector2(242, 362),
        anchor: Anchor.center,
        scale: Vector2(0.42, 0.42),
        position: position,
      );

  var startAnimation = false;
  var endAnimation = true;
  Vector2 previousPosition = Vector2(0, 0);
  final ec = LinearEffectController(1);
  final ec2 = LinearEffectController(1);

  @override
  FutureOr<void> onLoad() {
    add(OpenCard(Vector2(0, 0)));
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent info) {
    startAnimation = true;
    previousPosition = super.position;
  }

  @override
  void update(double dt) {
    if (startAnimation) {
      startAnimation = false;
      addAll([
        MoveToEffect(
          Vector2(0, 0),
          ec,
          onComplete: () {
            ec.setToStart();
          },
        ),
        RotateEffect.by(
          tau,
          ec2,
          onComplete: () {
            ec2.setToStart();
          },
        ),
      ]);
    }
    super.update(dt);
  }

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  // }
}
