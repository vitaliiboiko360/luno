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
        // scale: Vector2.all(scale),
      );

  @override
  FutureOr<void> onLoad() async {
    svg = await Svg.load('cards/UNO_black_background_card_back.svg');
    decorator = Rotate3DDecorator(angleY: 0, center: Vector2(width / 2, 0));
    return super.onLoad();
  }

  var scaleCtrl = EffectController(duration: 1);
  var turnCtrl = EffectController(duration: 1);

  // void animate(onComplete) {
  //   add(
  //     SequenceEffect(
  //       [
  //         ScaleEffect.to(Vector2.all(fullScale), scaleCtrl),
  //         FunctionEffect((target, progress) {
  //           (decorator as Rotate3DDecorator).angleY = (tau / 4) * progress;
  //         }, turnCtrl),
  //       ],
  //       onComplete: () {
  //         isVisible = false;
  //         removeFromParent();
  //         onComplete();
  //       },
  //     ),
  //   );
  // }

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

class PlayCard extends SvgComponent with HasVisibility {
  PlayCard({isVisible = false})
    : super(
        size: Vector2(width, height),
        anchor: Anchor.center,
        // scale: Vector2.all(fullScale),
      );

  @override
  FutureOr<void> onLoad() async {
    svg = await Svg.load('cards/${getRandomCardPath()}');
    decorator = Rotate3DDecorator(
      angleY: -tau / 4,
      center: Vector2(width / 2, height / 2),
    );
    return super.onLoad();
  }

  setAngle(angle) {
    (decorator as Rotate3DDecorator).angleY = angle;
  }

  setVisible() {
    isVisible = true;
  }

  @override
  void render(Canvas canvas) {
    try {
      super.render(canvas);
    } catch (error) {
      print('bad set angle: ${(decorator as Rotate3DDecorator).angleY}');
    }
  }
}

class LeftMove extends PositionComponent with HasVisibility {
  LeftMove()
    : super(
        size: Vector2(width, height),
        anchor: Anchor.center,
        scale: Vector2.all(fullScale),
        position: getPlayerPosition(PlayerSeat.left),
      );

  var cardToDisplay;
  var backCard;

  @override
  FutureOr<void> onLoad() async {
    cardToDisplay = PlayCard();
    backCard = BackCard();
    print('before add');
    addAll([backCard, cardToDisplay]);
    print('after add');
    super.onLoad();
  }

  double deltaTime = 0;

  var scaleCtrl = EffectController(duration: 1);
  var turnCtrl0 = EffectController(duration: 0.3);
  var turnCtrl = EffectController(duration: 0.3);
  var moveCtrl = EffectController(duration: 0.6);
  var rotateCtrl = EffectController(duration: 0.8);

  void animate() {
    // backCard.animate(() {
    // });
    add(
      SequenceEffect(
        [
          // FunctionEffect((target, progress) {
          //   backCard.setScale(scale + ((fullScale - scale) * progress));
          // }, scaleCtrl),
          FunctionEffect(
            (target, progress) {
              backCard.setAngle(-(tau / 4) * progress);
            },
            turnCtrl0,
            onComplete: () {
              backCard.setInvisible();
              cardToDisplay.setVisible();
            },
          ),
          FunctionEffect((target, progress) {
            cardToDisplay.setAngle((tau / 4) * (1 - progress));
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
    if (!animationStarted && deltaTime > 1) {
      animationStarted = true;
      deltaTime = 0;
      print('before animate');
      animate();
      print('after animate');
    }
    super.update(dt);
  }
}
