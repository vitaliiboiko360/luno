import 'dart:async';
import 'dart:math';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';

enum PlayerSeat { mainSeat, left, top, right }

Vector2 getPlayerPosition(PlayerSeat playerSeat) {
  if (playerSeat == PlayerSeat.left) {
    return Vector2(-300, 75);
  }
  if (playerSeat == PlayerSeat.top) {
    return Vector2(50, -350);
  }
  if (playerSeat == PlayerSeat.right) {
    return Vector2(300, -50);
  }
  return Vector2(75, 350);
}

const avatars = [
  'avatar1.png',
  'avatar10.png',
  'avatar15.png',
  'avatar2.png',
  'avatar3.png',
  'avatar4.png',
  'avatar5.png',
  'avatar6.png',
  'avatar9.png',
];

class PlayerPicture extends PositionComponent {
  PlayerPicture(PlayerSeat playerSeat)
    : super(
        position: getPlayerPosition(playerSeat),
        size: Vector2(150, 150),
        anchor: Anchor.center,
        // scale: Vector2(0.5, 0.5),
      );

  var image;

  @override
  Future<void> onLoad() async {
    image = await Flame.images.load('players/${avatars[Random().nextInt(9)]}');
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset(0, 0), 30, Paint()..color = Colors.black);
    canvas.drawImage(image, Offset(0, 0), Paint());
    super.render(canvas);
  }
}

class PlayerCustomPainter extends CustomPainter {
  late final border = Paint()
    ..color = Colors.blueGrey
    ..strokeWidth = 2
    //..blendMode = BlendMode.
    ..style = PaintingStyle.stroke;

  late final backGround = Paint()
    ..color = Colors.lightGreen
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    var rrect = RRect.fromRectAndRadius(
      Rect.fromLTRB(0, 0, 100, 100),
      Radius.circular(18),
    );
    canvas.drawRRect(rrect, backGround);
    canvas.drawRRect(rrect, border);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class PlayerBox extends CustomPainterComponent {
  PlayerBox(PlayerSeat playerSeat)
    : super(position: getPlayerPosition(playerSeat));

  var image;
  var tmp;
  @override
  FutureOr<void> onLoad() async {
    painter = PlayerCustomPainter();
    size = Vector2(100, 100);
    tmp = await Flame.images.load('players/${avatars[Random().nextInt(9)]}');
    image = Sprite(
      tmp,
      srcPosition: Vector2(0, 0),
      srcSize: Vector2(1024, 1024),
    ); //
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    (image as Sprite).render(canvas, size: Vector2(100, 100));
    // canvas.drawImage(tmp, Offset(0, 0), Paint());
  }
}
