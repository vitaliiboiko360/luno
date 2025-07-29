import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/rendering.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:luno/play/cards.dart';
import 'package:luno/play/player_box.dart';

const scale = 0.275;
const fullScale = 0.42;
const double width = 242;
const double height = 362;

class BackCard extends SvgComponent with HasVisibility {
  BackCard()
    : super(
        size: Vector2(width, height),
        anchor: Anchor.center,
        scale: Vector2.all(scale),
      );

  @override
  FutureOr<void> onLoad() async {
    svg = await Svg.load('cards/UNO_black_background_card_back.svg');
    decorator = Rotate3DDecorator(angleY: 0, center: Vector2(width / 2, 0));
    return super.onLoad();
  }

  var scaleCtrl = EffectController(duration: 1);
  var turnCtrl = EffectController(duration: 1);

  setAngle(angle) {
    (decorator as Rotate3DDecorator).angleY = angle;
  }

  setScale(scale) {
    scale = scale;
  }

  setInvisible() {
    isVisible = false;
  }
}

class PlayCard extends SvgComponent {
  PlayCard() : super(size: Vector2(width, height), anchor: Anchor.center);

  @override
  final decorator = Rotate3DDecorator(
    angleY: tau / 4.05,
    center: Vector2(width / 2, height / 2),
  );

  @override
  FutureOr<void> onLoad() async {
    svg = await Svg.load('cards/${getRandomCardPath()}');
    return super.onLoad();
  }

  setAngle(angle) {
    (decorator as Rotate3DDecorator).angleY = angle;
  }
}

class LeftMove extends PositionComponent with HasVisibility {
  LeftMove()
    : super(
        size: Vector2(width, height),
        anchor: Anchor.center,
        scale: Vector2.all(scale),
        position: getPlayerPosition(PlayerSeat.left) + Vector2(0, 70),
      );

  var cardToDisplay = PlayCard();
  var backCard = BackCard();

  @override
  FutureOr<void> onLoad() async {
    add(backCard);
    super.onLoad();
  }

  double deltaTime = 0;

  var scaleCtrl = EffectController(duration: .1);
  var turnCtrl0 = EffectController(duration: .3);
  var turnCtrl = EffectController(duration: .3);
  var moveCtrl = EffectController(startDelay: 0.2, duration: 0.6);
  var rotateCtrl = EffectController(startDelay: 0.2, duration: 0.8);

  void animate() {
    add(
      SequenceEffect(
        [
          FunctionEffect((target, progress) {
            super.scale = Vector2.all(scale + (fullScale - scale) * progress);
          }, scaleCtrl),
          FunctionEffect(
            (target, progress) {
              backCard.setAngle(-(tau / 4) * progress);
            },
            turnCtrl0,
            onComplete: () {
              backCard.setInvisible();
              add(cardToDisplay);
            },
          ),
          FunctionEffect((target, progress) {
            cardToDisplay.setAngle(((tau / 4.03) * (1 - progress)));
          }, turnCtrl),
        ],
        onComplete: () {
          addAll([
            MoveEffect.to(Vector2.zero(), moveCtrl),
            RotateEffect.by(
              tau,
              rotateCtrl,
              onComplete: () {
                findGame()!.world.add(
                  SvgComponent(
                    anchor: anchor,
                    svg: cardToDisplay.svg,
                    size: super.size,
                    scale: super.scale,
                    position: Vector2.zero(),
                    priority: -2,
                  ),
                );
                removeFromParent();
              },
            ),
          ]);
        },
      ),
    );
  }

  bool animationStarted = false;

  @override
  void update(double dt) {
    deltaTime += dt;
    if (!animationStarted) {
      animationStarted = true;
      deltaTime = 0;
      animate();
    }
    super.update(dt);
  }
}
