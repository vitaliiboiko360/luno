import 'package:flutter/material.dart';
import 'package:luno/colors/color_palette.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});
  final String title = 'play';
  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    double midWidth = width / 2;

    var padding = MediaQuery.paddingOf(context);
    double safeHeight = height - padding.top - padding.bottom;
    double midHeight = safeHeight / 2;

    return MediaQuery.withNoTextScaling(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: width,
          height: safeHeight,
          child: Stack(
            children: [
              Positioned(
                left: midWidth,
                top: midHeight,
                child: TextButton(
                  onPressed: () {
                    // pixiInit();
                  },
                  child: Text('Init'),
                ),
              ),
              Positioned(
                left: midWidth,
                top: midHeight + 40,
                child: TextButton(
                  onPressed: () {
                    // startStopMoving();
                  },
                  child: Text('Play'),
                ),
              ),
              Positioned(
                left: midWidth - 200,
                top: midHeight - 80,
                child: GestureDetector(
                  onTap: () {
                    print('pressed');
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      backgroundBlendMode: BlendMode.clear,
                      border: Border.all(width: 8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
