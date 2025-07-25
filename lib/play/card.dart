import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/geometry.dart';
import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';
import 'package:flame_svg/flame_svg.dart';

class UnoCard extends SvgComponent with TapCallbacks {
  UnoCard({super.position})
    : super(
        size: Vector2(242, 362),
        anchor: Anchor.center,
        scale: Vector2(0.42, 0.42),
        priority: -2,
      );

  var startAnimation = false;
  var endAnimation = true;
  Vector2 previousPosition = Vector2(0, 0);
  final ec = LinearEffectController(1);
  final ec2 = LinearEffectController(1);

  @override
  Future<void> onLoad() async {
    svg = await Svg.load('cards/UNO_black_background_card_back.svg');
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
        MoveByEffect(
          Vector2(-40, -40),
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

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}
