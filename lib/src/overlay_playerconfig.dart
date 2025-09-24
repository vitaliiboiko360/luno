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
        width: 300,
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
        child: Column(
          children: [
            Column(children: [ColorSet()]),
          ],
        ),
      ),
    );
  }
}

class ColorSet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(spacing: 2, children: [ColorSquare()]);
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
      child: Column(children: [Column(children: [
                
              ],
            )]),
    );
  }
}
