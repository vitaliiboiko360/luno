import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
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
        height: 400,
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
          color: const Color.fromARGB(255, 238, 236, 236),
        ),
        child: Column(
          children: [
            Column(children: [SizedBox(height: 50), Users()]),
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
        color: const Color.fromARGB(255, 211, 224, 226),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 173, 198, 243),
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
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: BoxBorder.all(color: Colors.indigoAccent),
      ),
    );
  }
}

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
      height: 225,
      decoration: BoxDecoration(
        color: const Color.fromARGB(162, 193, 199, 162),
        borderRadius: BorderRadius.all(Radius.circular(15)),
        border: BoxBorder.all(
          color: const Color.fromARGB(204, 194, 184, 139),
          width: 3,
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.directional(start: 10, end: 5),
            child: SvgPicture.asset(
              'assets/svg/geek_man.svg',
              width: 120,
              height: 120,
            ),
          ),
          Flexible(child: TextMessage()),
        ],
      ),
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
          top: 10,
          start: 10,
          end: 10,
          bottom: 10,
        ),
        child: Text(
          messageText,
          style: TextStyle(
            color: const Color.fromARGB(255, 61, 51, 6),
            fontSize: 24,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
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
    "The application is currently under active development. Please check out later for any updates.";
