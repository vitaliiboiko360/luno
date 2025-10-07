import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luno/play/player_box.dart';
import 'package:luno/state/table_state.dart';
import 'dart:ui' as ui;

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
  const ColorSet({super.key});
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 40),
      child: CarouselView(
        scrollDirection: Axis.horizontal,
        itemExtent: 40,
        children: List.generate(20, (int i) => ColorSquare(i)),
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
          color: colors[index % colors.length],
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
            // Color.fromARGB(255, colors1[0], colors1[1], colors1[2]),
            // Color.fromARGB(255, colors2[0], colors2[1], colors2[2]),
            colors[index % colors.length],
            colors[index % colors.length],
          ],
        ),
      ),
      child: Center(
        // child: Text(
        //   '$index',
        //   style: TextStyle(color: Colors.black, fontSize: 20),
        // ),
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
          children: List.generate(21, (int i) => AvatarBox(i, ref)),
        ),
      ),
    );
  }
}

class AvatarBox extends StatefulWidget {
  AvatarBox(this.index, this.ref, {super.key});
  int index;
  WidgetRef ref;
  @override
  State<StatefulWidget> createState() => _AvatarBoxState();
}

class _AvatarBoxState extends State<AvatarBox> {
  ui.Image? image;

  @override
  void initState() {
    super.initState();
    _loadImageAsset();
  }

  Future<void> _loadImageAsset() async {
    final imgUrl = 'images/players/${avatars[(widget.index) % avatars.length]}';

    final ByteData data = await rootBundle.load(imgUrl);
    final Uint8List bytes = data.buffer.asUint8List();
    image = await decodeImageFromList(bytes);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.ref.read(avatarProvider.notifier).setAvatarId(widget.index + 1);
      },
      child: CustomPaint(
        size: Size(102, 102),
        painter: AvatarBoxPainter(widget.index + 1, image),
      ),
    );
  }
}

class AvatarBoxPainter extends CustomPainter {
  AvatarBoxPainter(this.index, this.image);
  int index;
  ui.Image? image;

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

    final rect = Rect.fromLTRB(0, 0, 102, 102);

    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(10));
    canvas.drawRRect(rrect, fill);
    canvas.drawRRect(rrect, stroke);

    if (image == null) return;

    final imageRect = Rect.fromLTWH(
      0,
      0,
      image!.width.toDouble(),
      image!.height.toDouble(),
    );

    canvas.drawImageRect(image!, imageRect, rect, Paint());

    if (false) {
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
  }

  @override
  bool shouldRepaint(covariant AvatarBoxPainter oldDelegate) =>
      image != oldDelegate.image;
}
