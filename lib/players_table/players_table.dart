import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:luno/player_box/position.dart';

class PlayersTable extends CustomPainterComponent {
  @override
  FutureOr<void> onLoad() {
    var [width, height] = getTableDimentions().storage;
    painter = EllipsePainter(width, height);
    size = Vector2(width, height);
    anchor = Anchor.center;
    y = -25;
  }
}

class EllipsePainter extends CustomPainter {
  double width;
  double height;
  EllipsePainter(this.width, this.height);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    final paintStroke = Paint()
      ..color = const Color.fromARGB(255, 8, 97, 11)
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(0, 0, width, height);

    canvas.drawOval(rect, paint);
    canvas.drawOval(rect, paintStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Only repaint if necessary (e.g., if properties change)
  }
}
