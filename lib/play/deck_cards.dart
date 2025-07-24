import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/rendering.dart';
import 'package:flame/src/game/notifying_vector2.dart';

import 'package:flame_svg/svg.dart';
import 'package:flame_svg/svg_component.dart';

const width = 246;
const height = 362;
const scale = 0.42;

class DeckCard extends SvgComponent {
  DeckCard()
    : super(
        scale: Vector2.all(1),
        anchor: Anchor.center,
        size: Vector2(width / 10 * 4, height / 10 * 4),
      );

  @override
  Future<void> onLoad() async {
    svg = await Svg.load('cards/UNO_black_background_card_back.svg');
    decorator = Rotate3DDecorator(
      // center: Vector2(width / scale, height / scale),
      // angleX: -1.25,
      // angleZ: 0.43,
      angleX: -1.0, //-1.25,
      angleZ: 0.35,
      angleY: 0.0,
      perspective: 0,
    );
  }

  @override
  void render(Canvas canvas) {
    svg!.render(canvas, size);
    super.render(canvas);
  }
}

class DeckCardPositioned extends SvgComponent {
  DeckCardPositioned(Vector2 position, this.centerCoords)
    : super(
        scale: Vector2.all(1),
        anchor: Anchor.center,
        size: Vector2(width / 10 * 3, height / 10 * 3),
        position: position,
      );

  Vector2 centerCoords;

  @override
  Future<void> onLoad() async {
    svg = await Svg.load('cards/UNO_black_background_card_back.svg');
    decorator = Rotate3DDecorator(
      // center: Vector2(width / scale, height / scale),
      // angleX: -1.25,
      // angleZ: 0.43,
      center: centerCoords,
      angleX: -1.0, //-1.25,
      angleZ: 0.3,
      angleY: 0.15,
      perspective: 0,
    );
  }

  @override
  void render(Canvas canvas) {
    svg!.render(canvas, size);
    super.render(canvas);
  }
}

class DeckCards extends PositionComponent {
  DeckCards()
    : super(
        anchor: Anchor.center,
        position: Vector2(-300, -350),
        children: [
          DeckCardPositioned(Vector2(0, 0), Vector2(14, 46)),
          DeckCardPositioned(Vector2(0, 0), Vector2(16, 42)),
          DeckCardPositioned(Vector2(0, 0), Vector2(18, 38)),
          DeckCardPositioned(Vector2(0, 0), Vector2(20, 34)),
          DeckCardPositioned(Vector2(0, 0), Vector2(22, 30)),
          DeckCardPositioned(Vector2(0, 0), Vector2(24, 26)),
          DeckCardPositioned(Vector2(0, 0), Vector2(26, 22)),
          DeckCardPositioned(Vector2(0, 0), Vector2(28, 18)),
          DeckCardPositioned(Vector2(0, 0), Vector2(30, 14)),
        ],
      );

  @override
  Future<void> onLoad() async {
    decorator = Rotate3DDecorator(angleY: -0.1);
  }

  // @override
  // void render(Canvas canvas) {
  //   // (svg as Svg).render(canvas, size);
  //   children.forEach((a) => a.render(canvas));
  //   super.render(canvas);
  // }
}

class DeckCardsPositioned extends PositionComponent {
  DeckCardsPositioned()
    : super(
        anchor: Anchor.center,
        position: Vector2(-200, -250),
        children: [DeckCards()],
      );
}
