import 'package:app/util/design.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  const Label({super.key, required this.text, this.color = Design.lightBlue});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      margin: const EdgeInsets.only(top: 20, bottom: 0),
      child: Text(
        text,
        style: TextStyle(fontFamily: "Roboto", fontSize: 14, color: color),
      ),
    );
  }
}
