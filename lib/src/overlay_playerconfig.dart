import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:luno/state/table_game_manager.dart';
import 'package:luno/state/table_state.dart';
import 'package:provider/provider.dart';
import 'package:riverpod/riverpod.dart';

class PlayerConfig extends StatefulWidget {
  const PlayerConfig({super.key});

  @override
  State<PlayerConfig> createState() => _PlayerConfigState();
}

class _PlayerConfigState extends State<PlayerConfig> {
  _PlayerConfigState();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 328,
        height: 468,
        clipBehavior: Clip.hardEdge,
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
          border: BoxBorder.all(
            color: Colors.blue,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 171, 205, 233),
              const Color.fromARGB(255, 161, 189, 240),
            ],
          ),
          // color: const Color.fromARGB(255, 238, 236, 236),
        ),
        child: Column(children: [ColorSet(), AvatarsGrid()]),
      ),
    );
  }
}

class ColorSet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 40),
      child: CarouselView(
        scrollDirection: Axis.horizontal,
        itemExtent: 40,
        children: List.generate(20, (int i) => ColorSquare(i + 1)),
      ),
    );
  }
}

class ColorSquare extends StatelessWidget {
  int index;
  ColorSquare(this.index, {super.key});
  var colors1 = List<int>.generate(3, (int) => Random().nextInt(256));
  var colors2 = List<int>.generate(3, (int) => Random().nextInt(256));
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      clipBehavior: Clip.hardEdge,
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(2)),
        border: BoxBorder.all(
          color: Colors.blue,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(2)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, colors1[0], colors1[1], colors1[2]),
            Color.fromARGB(255, colors2[0], colors2[1], colors2[2]),
          ],
        ),
      ),
      child: Center(
        child: Text(
          '$index',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}

class AvatarsGrid extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Flexible(
      child: Padding(
        padding: EdgeInsetsGeometry.directional(start: 3),
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(3),
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          crossAxisCount: 3,
          children: List.generate(21, (int i) => avatarBox(i, ref)),
        ),
      ),
    );
  }
}

//
var avatarBox = (int i, WidgetRef ref) => GestureDetector(
  onTap: () {
    ref.read(avatarProvider.notifier).setAvatarId(i + 1);
  },
  child: CustomPaint(size: Size(102, 102), painter: AvatarBoxPainter(i + 1)),
);

class AvatarBoxPainter extends CustomPainter {
  int index;
  AvatarBoxPainter(this.index);
  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = 2
      ..filterQuality = FilterQuality.high
      ..style = PaintingStyle.stroke;

    var fill = Paint()
      ..color = const Color.fromARGB(255, 204, 204, 204)
      ..filterQuality = FilterQuality.high
      ..style = PaintingStyle.fill;

    var rrect = RRect.fromRectAndRadius(
      Rect.fromLTRB(0, 0, 102, 102),
      Radius.circular(10),
    );
    canvas.drawRRect(rrect, fill);
    canvas.drawRRect(rrect, stroke);

    final textPainter = TextPainter(
      text: TextSpan(
        text: '$index',
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
      textDirection: TextDirection.ltr, // Adjust as needed
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width);

    final xOffset = (size.width - textPainter.width) / 2;
    final yOffset = (size.height - textPainter.height) / 2;
    final textOffset = Offset(xOffset, yOffset);

    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
