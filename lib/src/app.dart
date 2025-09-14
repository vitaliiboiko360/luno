import 'package:flutter/material.dart';
import 'package:luno/play/game.dart';
import 'package:luno/state/table_game_manager.dart';
import 'package:luno/style/color_palette.dart';
import 'package:luno/ws/ws.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  App(this.tgm, this.imagePath, {super.key});

  TableGameManager tgm;
  String imagePath;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Game(tgm, screenWidth, screenHeight, imagePath);
  }
}

        // child: Builder(
        //   builder: (context) {
        //     final palette = context.watch<Palette>();
        //     return MaterialApp.router(
        //       title: 'Uno Game',
        //       theme:
        //           ThemeData.from(
        //             colorScheme: ColorScheme.fromSeed(
        //               seedColor: palette.darkPen,
        //               surface: palette.backgroundMain,
        //             ),
        //             textTheme: TextTheme(
        //               bodyMedium: TextStyle(color: palette.ink),
        //             ),
        //             useMaterial3: true,
        //           ).copyWith(
        //             filledButtonTheme: FilledButtonThemeData(
        //               style: FilledButton.styleFrom(
        //                 textStyle: const TextStyle(
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 20,
        //                 ),
        //               ),
        //             ),
        //           ),
        //       routerConfig: router,
        //     );
        //   },
        // ),