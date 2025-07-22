import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/geometry.dart';
import 'package:flame/extensions.dart';
import 'package:flame_svg/flame_svg.dart';

class UnoCard extends SvgComponent with TapCallbacks {
  UnoCard({super.position})
    : super(size: Vector2.all(200), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    svg = await Svg.load('cards/UNO_black_background_card_back.svg');
  }

  @override
  void onTapUp(TapUpEvent info) {
    print('on tap');
  }
}
