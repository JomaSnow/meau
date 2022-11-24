import 'package:app/util/design.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.value, required this.onPressed});

  final String value;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(5.0),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: 12)),
          backgroundColor:
              MaterialStateProperty.all<Color>(Design.primaryYellow),
          overlayColor:
              MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Design.primaryYellow.withOpacity(0.6);
            }
            if (states.contains(MaterialState.focused) ||
                states.contains(MaterialState.selected)) {
              return Design.primaryYellow.withOpacity(0.8);
            }
            return null;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
        ),
        child: Center(
            child: Text(
          value,
          style: const TextStyle(
              color: Design.darkerGray, fontSize: 12, fontFamily: "Roboto"),
        )),
      ),
    );
  }
}
