import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:luno/state/table_game_manager.dart';

class TakeSeatButton extends AdvancedButtonComponent {
  TakeSeatButton(this.tgm, {Anchor? anchor, Vector2? position})
    : super(
        defaultSkin: TakeSeatButtonUp(),
        downSkin: TakeSeatButtonDown(),
        defaultLabel: ButtonLabel(),
        onPressed: () {
          print('button pressed ctor');
        },
        size: Vector2(90, 60),
        anchor: anchor ?? Anchor.topLeft,
        position: position ?? Vector2.zero(),
      );

  TableGameManager tgm;

  @override
  Future<void> onLoad() async {
    super.onPressed = () {
      print('button pressed onLoad');
    };
    return super.onLoad();
  }

  void onTapUp(TapUpEvent event) {
    print('button pressed onTapUp');
    super.onTapUp(event);
  }

  void onTapDown(TapDownEvent event) {
    print('button pressed onTapDown');
    (defaultSkin as TakeSeatButtonUp).updateColorRand();
    super.onTapDown(event);
  }

  double dtAccumulated = 0;

  // @override
  // void update(double dt) {
  //   dtAccumulated += dt;
  //   if (dtAccumulated > 1) {
  //     (defaultSkin as TakeSeatButtonUp).updateColors(tgm.color);
  //     dtAccumulated = 0;
  //   }
  //   // if (!tgm.isColorProccessed) {
  //   //   tgm.setProcessed();
  //   // }
  //   super.update(dt);
  // }
}

class ButtonLabel extends CustomPainterComponent {
  ButtonLabel() : super(size: Vector2(90, 60));
  @override
  FutureOr<void> onLoad() {
    super.painter = ButtonLabelPainter();
    return super.onLoad();
  }
}

class ButtonLabelPainter_Connecting extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var ts = TextSpan(
      text: "Connecting",
      style: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.8,
      ),
    );
    var tp = TextPainter(
      text: ts,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    tp.layout(minWidth: 0, maxWidth: 90);
    tp.paint(canvas, Offset(0, 6));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ButtonLabelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var ts = TextSpan(
      text: "Take Seat",
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.8,
      ),
    );
    var tp = TextPainter(
      text: ts,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    tp.layout(minWidth: 0, maxWidth: 90);
    tp.paint(canvas, Offset(0, 6));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class TakeSeatButtonUp extends CustomPainterComponent {
  @override
  FutureOr<void> onLoad() {
    super.painter = ButtonPainter();
    return super.onLoad();
  }

  void updateColors(Color color) {
    (painter as ButtonPainter).updateColors(color);
  }

  void updateColorRand() {
    (painter as ButtonPainter).updateColorRand();
  }
}

class ButtonPainter extends CustomPainter {
  Color strokeColor = Colors.lime;
  Color fillColor = Colors.green;

  void updateColors(Color color) {
    fillColor = color;
  }

  void updateColorRand() {
    fillColor = Color.fromARGB(
      71,
      Random().nextInt(255),
      Random().nextInt(255),
      Random().nextInt(255),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    var p = Paint();
    p.strokeWidth = 2;
    p.color = strokeColor;
    p.style = PaintingStyle.stroke;
    var r = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, 90, 60),
      Radius.circular(14),
    );
    canvas.drawRRect(r, p);
    var p2 = Paint();
    p2.color = fillColor;
    p2.style = PaintingStyle.fill;
    var r2 = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, 90, 60),
      Radius.circular(14),
    );
    canvas.drawRRect(r2, p2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class TakeSeatButtonDown extends CustomPainterComponent {
  @override
  FutureOr<void> onLoad() {
    painter = ButtonPainter2();
    return super.onLoad();
  }
}

class ButtonPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var p = Paint();
    p.strokeWidth = 2;
    p.color = Colors.green;
    p.style = PaintingStyle.fill;
    var r = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, 90, 60),
      Radius.circular(14),
    );
    canvas.drawRRect(r, p);
    var p2 = Paint();
    p2.strokeWidth = 2;
    p2.color = Colors.teal;
    p2.style = PaintingStyle.stroke;
    var r2 = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, 90, 60),
      Radius.circular(14),
    );
    canvas.drawRRect(r2, p2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
