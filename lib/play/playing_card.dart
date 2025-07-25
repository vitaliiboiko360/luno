import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/geometry.dart';
import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:luno/play/active_hand.dart';
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

  // @override
  // void onTapUp(TapUpEvent info) {
  //   // startAnimation = true;
  //   // previousPosition = super.position;
  //   print('clicked svg card');
  // }
  //with TapCallbacks
}

class PlayingCard extends SvgComponent with TapCallbacks {
  PlayingCard(position)
    : super(
        size: Vector2(width, height),
        anchor: Anchor.center,
        scale: Vector2(scale, scale),
        position: position,
      );

  var startAnimation = false;
  var endAnimation = false;
  Vector2 previousPosition = Vector2(0, 0);
  final moveCtrl = LinearEffectController(0.8);
  final rotateCtrl = LinearEffectController(1);

  @override
  FutureOr<void> onLoad() async {
    svg = await Svg.load('cards/${getRandomCardPath()}');
  }

  @override
  void onTapUp(TapUpEvent info) {
    startAnimation = true;
    // previousPosition = super.position;
    (parent as ActiveHand).playCard();

    print('clicked card');
  }

  @override
  void update(double dt) {
    if (startAnimation) {
      startAnimation = false;
      priority = 1;
      addAll([
        MoveToEffect(
          absolutePosition.inverted() + position,
          moveCtrl,
          onComplete: () {
            moveCtrl.setToStart();
          },
        ),
        RotateEffect.by(
          tau,
          rotateCtrl,
          onComplete: () {
            rotateCtrl.setToStart();
            // opacity = 0;
            findGame()!.world.add(
              SvgComponent(
                anchor: anchor,
                svg: svg,
                size: super.size,
                scale: super.scale,
                position: Vector2.zero(),
                priority: -1,
              ),
            );
            removeFromParent();

            // opacity = 1;
          },
        ),
      ]);
    }

    if (endAnimation) {
      print('end of animation effect');
      endAnimation = false;
    }
    super.update(dt);
  }

  @override
  void onRemove() {
    print('on remove');
    (parent as ActiveHand).rearangeCards();
    (parent as ActiveHand).addCard();
    // position = Vector2.zero();
    // priority = 0;
    endAnimation = true;
    super.onRemove();
  }

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  // }
}
