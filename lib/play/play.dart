import 'package:flutter/material.dart';
import 'package:luno/js/pixi.dart';
import 'package:luno/style/color_palette.dart';
import 'package:provider/provider.dart';

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

    return MediaQuery.withNoTextScaling(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  pixiInit();
                },
                child: Text('Init'),
              ),
              TextButton(
                onPressed: () {
                  startStopMoving();
                },
                child: Text('Play'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
