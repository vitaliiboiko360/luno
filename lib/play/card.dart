import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/geometry.dart';
import 'package:flame/extensions.dart';

class UnoCard extends SpriteComponent with TapCallbacks {
  UnoCard({super.position})
    : super(size: Vector2.all(200), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('ast/UNO_black_background_UnoCard_back.svg');
  }

  @override
  void onTapUp(TapUpEvent info) {
    print('on tap');
  }
}
