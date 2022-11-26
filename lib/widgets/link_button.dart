import 'package:app/util/design.dart';
import 'package:flutter/material.dart';

class LinkButton extends StatelessWidget {
  const LinkButton(
      {super.key,
      required this.value,
      required this.onPressed,
      this.width = double.infinity,
      this.fontColor = Design.lightBlue});

  final String value;
  final VoidCallback onPressed;
  final Color fontColor;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: 12)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
        ),
        child: Center(
          child: Text(
            value,
            style:
                TextStyle(color: fontColor, fontSize: 16, fontFamily: "Roboto"),
          ),
        ),
      ),
    );
  }
}
