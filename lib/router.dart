import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:luno/play/game.dart';
import 'package:luno/src/home.dart';
import 'package:luno/play/play.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(key: Key('main menu')),
      routes: [
        GoRoute(
          path: 'play',
          builder: (context, state) => const Game(key: Key('play')),
        ),
      ],
    ),
  ],
);
