import 'dart:async';
import 'dart:ui' as ui;
import 'package:flame/components.dart';
import 'package:flame/src/events/messages/tap_down_event.dart';
import 'package:flutter/material.dart';
import 'package:luno/player_box/position.dart';
import 'package:luno/src/game.dart';

class ButtonChangeAvatar extends AdvancedButtonComponent
    with HasGameReference<Game> {
  ButtonChangeAvatar()
    : super(
        defaultSkin: DefaultButtonChangeAvatar(),
        // downSkin: DownButtonChangeAvatar(),
        // hoverSkin: HoverButtonChangeAvatar(),
        anchor: Anchor.topLeft,
        position: getChangeAvatarButtonPosition(),
        size: Vector2(25, 25),
      );

  @override
  Future<void> onLoad() {
    onPressed = () {
      print("on pressed from onload");
      game.showPlayerConfigOverlay();
    };
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
    var roundedRect = RRect.fromLTRBR(0, 0, 25, 25, Radius.circular(2));
    canvas.drawRRect(roundedRect, strokePaint);
    var fillPaint = Paint()
      ..shader = ui.Gradient.radial(Offset(10, 0), 100, [
        const ui.Color.fromARGB(255, 117, 186, 226),
        const ui.Color.fromARGB(255, 159, 195, 243),
      ])
      ..color = const ui.Color.fromARGB(255, 184, 208, 221)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(roundedRect, fillPaint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(Icons.edit.codePoint),
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: Icons.edit.fontFamily,
        ),
      ),
      textDirection: TextDirection.ltr, // Adjust as needed
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width);

    double xOffset = 2;
    // (size.width) / 2;
    double yOffset = 2;
    //(size.height) / 2;
    final textOffset = Offset(xOffset, yOffset);

    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
