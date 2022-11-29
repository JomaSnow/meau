import 'package:app/util/design.dart';
import 'package:flutter/material.dart';

class NoticeCard extends StatelessWidget {
  const NoticeCard(
      {super.key, this.backgroundColor = Design.accentBlue, this.text = ""});
  final Color backgroundColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: backgroundColor),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontFamily: "Roboto", fontSize: 14, color: Design.darkerGray),
      ),
    );
  }
}
