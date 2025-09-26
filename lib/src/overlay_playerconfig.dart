import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

class PlayerConfig extends StatefulWidget {
  PlayerConfig({super.key});

  @override
  State<PlayerConfig> createState() => _PlayerConfigState();
}

class _PlayerConfigState extends State<PlayerConfig> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 328,
        height: 460,
        clipBehavior: Clip.hardEdge,
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
          border: BoxBorder.all(
            color: Colors.blue,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
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
//ColorSet(),

class ColorSet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 40),
      child: CarouselView(
        scrollDirection: Axis.horizontal,
        itemExtent: 40,
        children: List.filled(12, ColorSquare()),
      ),
    );
  }
}

class ColorSquare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      clipBehavior: Clip.hardEdge,
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(3)),
        border: BoxBorder.all(
          color: Colors.blue,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(3)),
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
      child: Column(children: [Column(children: [])]),
    );
  }
}

class AvatarsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(3),
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        crossAxisCount: 3,
        children: List.filled(21, avatarBox()),
      ),
    );
  }
}

//
var avatarBox = () =>
    CustomPaint(size: Size(102, 102), painter: AvatarBoxPainter());

class AvatarBoxPainter extends CustomPainter {
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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
