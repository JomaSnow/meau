import 'package:app/util/design.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      required this.value,
      required this.onPressed,
      this.width = double.infinity,
      this.disabled = false,
      this.color = Design.primaryYellow,
      this.fontColor = Design.darkerGray});

  final String value;
  final VoidCallback onPressed;
  final Color color;
  final Color fontColor;
  final double width;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ButtonStyle(
          elevation: disabled ? null : MaterialStateProperty.all<double>(5.0),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: 12)),
          backgroundColor: disabled
              ? MaterialStateProperty.all<Color>(color.withOpacity(0.6))
              : MaterialStateProperty.all<Color>(color),
          overlayColor:
              MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return color.withOpacity(0.6);
            }
            if (states.contains(MaterialState.focused) ||
                states.contains(MaterialState.selected)) {
              return color.withOpacity(0.8);
            }
            return null;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
        ),
        child: Center(
            child: Text(
          value,
          style: TextStyle(
              color: disabled ? Design.lighterGray : fontColor,
              fontSize: 12,
              fontFamily: "Roboto"),
        )),
      ),
    );
  }
}
