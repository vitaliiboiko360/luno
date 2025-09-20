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
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
          color: const Color.fromARGB(255, 238, 236, 236),
          border: BoxBorder.all(
            color: Colors.blue,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            Column(children: [SizedBox(height: 60), Users()]),
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
      spacing: 10,
      children: [UserBlock(), UserBlock(), UserBlock(), UserBlock()],
    );
  }
}

class UserBlock extends StatelessWidget {
  UserBlock({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.directional(start: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Column(spacing: 5, children: [UserImageFrame(), UserText()]),
        ],
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
        borderRadius: BorderRadius.all(Radius.circular(15)),
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
