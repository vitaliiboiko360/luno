import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

class ReadyTable extends StatefulWidget {
  ReadyTable({super.key});

  @override
  State<ReadyTable> createState() => _ReadyTableState();
}

class _ReadyTableState extends State<ReadyTable> {
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
            Column(
              children: [
                SizedBox(height: 90, child: TitleBlock()),
                Users(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Users extends StatelessWidget {
  Users({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 2,
      children: [UserBlock(), UserBlock(), UserBlock(), UserBlock()],
    );
  }
}

class UserBlock extends StatelessWidget {
  UserBlock({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: const Color.fromARGB(157, 211, 226, 225),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromARGB(157, 211, 226, 225),
            const Color.fromARGB(6, 255, 255, 255),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(123, 173, 198, 243),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.directional(start: 20, top: 8, bottom: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [UserImageFrame(), UserText()],
            ),
          ],
        ),
      ),
    );
  }
}

class UserText extends StatelessWidget {
  static int id = 0;
  String text = "Player Name #${UserText.id++}";
  UserText({String? textInput, super.key}) {
    if (textInput != null) {
      text = textInput;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

class UserImageFrame extends StatelessWidget {
  UserImageFrame({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(197, 146, 172, 194),
            offset: Offset(2, 2),
            blurRadius: 3,
          ),
        ],
        color: const Color.fromARGB(255, 223, 232, 250),
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: BoxBorder.all(color: const Color.fromARGB(255, 110, 129, 235)),
      ),
    );
  }
}

class TitleBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(157, 130, 195, 221),
            const Color.fromARGB(120, 224, 227, 235),
          ],
        ),
      ),
      child: Row(children: [TitleText()]),
    );
  }
}

class TitleText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: Flexible(
          fit: FlexFit.tight,
          child: Text(
            titleText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color.fromARGB(255, 18, 22, 27),
              fontSize: 20,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}

const titleText = "Game will start when all players are ready";

//
// Anouncement

Widget readyTable(BuildContext context, FlameGame game) {
  return Center(
    child: Column(
      children: [Text('Game Will Start When All Players Are Ready')],
    ),
  );
}

class Anouncement extends StatelessWidget {
  Anouncement({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: OuterContainer());
  }
}

class OuterContainer extends StatelessWidget {
  OuterContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 475,
      height: 175,
      decoration: BoxDecoration(
        color: const Color.fromARGB(162, 193, 199, 162),
        borderRadius: BorderRadius.all(Radius.circular(15)),
        border: BoxBorder.all(
          color: const Color.fromARGB(204, 194, 184, 139),
          width: 3,
        ),
      ),
      child: TextMessage(),
    );
  }
}

class TextMessage extends StatelessWidget {
  TextMessage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsetsGeometry.directional(
          top: 30,
          start: 30,
          end: 30,
          bottom: 30,
        ),
        child: Text(
          messageText,
          style: TextStyle(
            color: const Color.fromARGB(255, 61, 51, 6),
            fontSize: 26,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Color.fromARGB(255, 223, 224, 217),
                offset: Offset(2, 2),
                blurRadius: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const messageText =
    "The application is under active development. Please check out later for any updates.";
