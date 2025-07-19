import 'package:flutter/material.dart';
import 'package:luno/app_lifecycle/app_lifecycle.dart';
import 'package:luno/style/color_palette.dart';
import 'package:provider/provider.dart';
import 'package:luno/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [Provider(create: (context) => Palette())],
        builder: (context, child) {
          return MediaQuery.withNoTextScaling(child: child!);
        },
        child: Builder(
          builder: (context) {
            final palette = context.watch<Palette>();
            return MaterialApp.router(
              title: 'Uno Game',
              theme:
                  ThemeData.from(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: palette.darkPen,
                      surface: palette.backgroundMain,
                    ),
                    textTheme: TextTheme(
                      bodyMedium: TextStyle(color: palette.ink),
                    ),
                    useMaterial3: true,
                  ).copyWith(
                    filledButtonTheme: FilledButtonThemeData(
                      style: FilledButton.styleFrom(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
              routerConfig: router,
            );
          },
        ),
      ),
    );
  }
}
