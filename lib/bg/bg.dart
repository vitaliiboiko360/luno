import 'package:flutter/material.dart';

const images = [
  'images/bg/marek-piwnicki.jpg',
  'images/bg/justin-luebke.jpg',
  'images/bg/silas-baisch.jpg',
  'images/bg/denver-saldanha.jpg',
  'images/bg/dan-meyers.jpg',
  'images/bg/vedant-sonani.jpg',
  'images/bg/fabrizio-conti.jpg',
  'images/bg/davide-longo.jpg',
  'images/bg/lake-tahoe-boat.jpg',
  'images/bg/marek-okon.jpg',
  'images/bg/daniel-meyer.jpg',
];

WidgetBuilder buildBackground(imagePath, screenWidth, screenHeight) {
  return (BuildContext context) => Stack(
    children: [
      Center(
        child: Image.asset(
          imagePath,
          width: screenWidth,
          height: screenHeight,
          fit: ((screenWidth / screenHeight) * 10).toInt() > 15
              ? BoxFit.fitWidth
              : BoxFit.fitHeight,
        ),
      ),
      Center(
        child: Container(
          // decoration: BoxDecoration(color: Colors.green),
          // child: SizedBox(width: screenWidth / 2, height: screenHeight / 2),
          child: CustomPaint(
            size: Size(
              getWidth(screenWidth, screenHeight),
              getHeight(screenHeight),
            ),
            painter: EllipsePainter(
              getWidth(screenWidth, screenHeight),
              getHeight(screenHeight),
            ),
          ),
        ),
      ),
    ],
  );
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

getWidth(width, height) {
  if (width > height) {
    return (height * 2 / 5).truncate();
  } else {
    return (width * 8 / 10).truncate();
  }
}

getHeight(height) {
  return (height * 6 / 10).truncate();
}
