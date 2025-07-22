import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/geometry.dart';
import 'package:flame/extensions.dart';
import 'package:flame_svg/flame_svg.dart';

class UnoCard extends SvgComponent with TapCallbacks {
  UnoCard({super.position})
    : super(size: Vector2.all(150), anchor: Anchor.center);

  var startAnimation = false;
  Vector2 previousPosition = Vector2(0, 0);

  @override
  Future<void> onLoad() async {
    svg = await Svg.load('cards/UNO_black_background_card_back.svg');
  }

  @override
  void onTapUp(TapUpEvent info) {
    print('on tap');
    startAnimation = true;
    previousPosition = super.position;
  }

  @override
  void update(double dt) {
    if (startAnimation) {
      position = position - Vector2(-10, 10);
      startAnimation = false;
    }
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}
