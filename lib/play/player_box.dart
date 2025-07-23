import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:flutter/material.dart';

enum PlayerSeat { mainSeat, left, top, right }

Vector2 getPlayerPosition(PlayerSeat playerSeat) {
  if (PlayerSeat == PlayerSeat.left) {
    return Vector2(-200, -50);
  }
  if (PlayerSeat == PlayerSeat.top) {
    return Vector2(-50, -200);
  }
  if (PlayerSeat == PlayerSeat.right) {
    return Vector2(200, -50);
  }
  return Vector2(0, 200);
}

const avatars = [
  'avatar1.svg',
  'avatar10.svg',
  'avatar15.svg',
  'avatar2.svg',
  'avatar3.svg',
  'avatar4.svg',
  'avatar5.svg',
  'avatar6.svg',
  'avatar9.svg',
];

class SvgPicture extends SvgComponent {
  SvgPicture(PlayerSeat playerSeat)
    : super(
        position: getPlayerPosition(playerSeat),
        size: Vector2(242, 362),
        anchor: Anchor.center,
        scale: Vector2(0.5, 0.5),
      );

  @override
  Future<void> onLoad() async {
    svg = await Svg.load('players/${avatars[Random().nextInt(10)]}');
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset(0, 0), 30, Paint()..color = Colors.black);
    super.render(canvas);
  }
}

class PlayerCustomPainter extends CustomPainter {
  late final facePaint = Paint()..color = Colors.yellow;

  late final eyesPaint = Paint()..color = Colors.black;

  @override
  void paint(Canvas canvas, Size size) {
    final faceRadius = size.height / 2;

    canvas.drawCircle(Offset(faceRadius, faceRadius), faceRadius, facePaint);

    final eyeSize = faceRadius * 0.15;

    canvas.drawCircle(
      Offset(faceRadius - (eyeSize * 2), faceRadius - eyeSize),
      eyeSize,
      eyesPaint,
    );

    canvas.drawCircle(
      Offset(faceRadius + (eyeSize * 2), faceRadius - eyeSize),
      eyeSize,
      eyesPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
