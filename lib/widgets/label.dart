import 'package:app/util/design.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  const Label({
    super.key,
    required this.text,
    this.color = Design.lightBlue,
    this.margin = const EdgeInsets.only(top: 20, left: 10),
  });
  final String text;
  final Color color;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Text(
        text,
        style: TextStyle(fontFamily: "Roboto", fontSize: 14, color: color),
      ),
    );
  }
}
