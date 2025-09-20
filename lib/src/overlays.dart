import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        child: Column(children: [Column(children: [

        ],)]),
      ),
    );
  }
}

class UserBlock extends StatelessWidget {
  UserBlock({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
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
