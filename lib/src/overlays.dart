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
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
        color: Colors.white,
        border: BoxBorder.all(
          color: Colors.blue,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(children: []),
    );
  }
}
