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
          decoration: BoxDecoration(color: Colors.green),
          child: SizedBox(width: screenWidth / 2, height: screenHeight / 2),
        ),
      ),
    ],
  );
}
