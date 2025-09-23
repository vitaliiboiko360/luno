import 'dart:async';
import 'dart:ui' as ui;
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:luno/player_box/position.dart';

class ButtonReady extends AdvancedButtonComponent {
  ButtonReady()
    : super(
        defaultSkin: DefaultButtonReady(),
        downSkin: DownButtonReady(),
        hoverSkin: HoverButtonReady(),
        anchor: Anchor.center,
      );

  @override
  Future<void> onLoad() {
    position = getReadyButtonPosition();
    return super.onLoad();
  }
}

class DefaultButtonReady extends CustomPainterComponent {
  DefaultButtonReady();

  @override
  FutureOr<void> onLoad() {
    painter = PainterButtonReady();
    return super.onLoad();
  }
}

class DownButtonReady extends PositionComponent {}

class HoverButtonReady extends PositionComponent {}

class PainterButtonReady extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var strokePaint = Paint()
      ..color = const ui.Color.fromARGB(255, 122, 134, 9)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    var roundedRect = RRect.fromLTRBR(0, 0, 150, 100, Radius.circular(50));
    canvas.drawRRect(roundedRect, strokePaint);
    var fillPaint = Paint()
      ..shader = ui.Gradient.radial(Offset(75, 0), 100, [
        Colors.green,
        Colors.lime,
      ])
      ..color = Colors.lightGreen
      ..style = PaintingStyle.fill;
    canvas.drawRRect(roundedRect, fillPaint);
    var textSpan = TextSpan(
      text: 'Ready',
      style: TextStyle(fontSize: 26, color: Colors.white),
    );
    var textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(minWidth: 0, maxWidth: 150);
    textPainter.paint(canvas, Offset(42, 35));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
