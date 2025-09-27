import 'dart:async';
import 'dart:ui' as ui;
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:luno/player_box/position.dart';

class ButtonChangeAvatar extends AdvancedButtonComponent {
  ButtonChangeAvatar()
    : super(
        defaultSkin: DefaultButtonChangeAvatar(),
        downSkin: DownButtonChangeAvatar(),
        hoverSkin: HoverButtonChangeAvatar(),
        anchor: Anchor.center,
        position: Vector2(50, 50),
      );

  @override
  Future<void> onLoad() {
    position = getReadyButtonPosition();
    return super.onLoad();
  }
}

class DefaultButtonChangeAvatar extends CustomPainterComponent {
  DefaultButtonChangeAvatar();

  @override
  FutureOr<void> onLoad() {
    painter = PainterButtonChangeAvatar();
    return super.onLoad();
  }
}

class DownButtonChangeAvatar extends PositionComponent {}

class HoverButtonChangeAvatar extends PositionComponent {}

class PainterButtonChangeAvatar extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var strokePaint = Paint()
      ..color = const ui.Color.fromARGB(255, 47, 95, 117)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    var roundedRect = RRect.fromLTRBR(0, 0, 20, 20, Radius.circular(2));
    canvas.drawRRect(roundedRect, strokePaint);
    var fillPaint = Paint()
      ..shader = ui.Gradient.radial(Offset(10, 0), 100, [
        const ui.Color.fromARGB(255, 117, 186, 226),
        const ui.Color.fromARGB(255, 159, 195, 243),
      ])
      ..color = const ui.Color.fromARGB(255, 184, 208, 221)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(roundedRect, fillPaint);
    // var textSpan = TextSpan(
    //   text: String.fromCharCode(Icons.edit.codePoint),
    //   style: TextStyle(
    //     fontSize: 26,
    //     color: ui.Color.fromARGB(255, 47, 95, 117),
    //   ),
    // );
    // var textPainter = TextPainter(
    //   text: textSpan,
    //   textDirection: TextDirection.ltr,
    //   textAlign: TextAlign.center,
    // );
    // textPainter.layout(minWidth: 0, maxWidth: 20);
    // textPainter.paint(canvas, Offset(2, 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
