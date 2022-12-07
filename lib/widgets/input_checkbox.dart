import 'package:app/util/design.dart';
import 'package:flutter/material.dart';

class InputSingleCheckbox extends StatelessWidget {
  const InputSingleCheckbox({
    super.key,
    required this.onChanged,
    required this.value,
    this.enabled = true,
    required this.title,
    this.singleLine = false,
  });

  final Function(bool?) onChanged;
  final bool value;
  final bool enabled;
  final String title;
  final bool singleLine;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: singleLine ? MainAxisSize.max : MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          checkColor: Design.white,
          activeColor: Design.primaryYellow,
          onChanged: enabled ? onChanged : null,
        ),
        Text(
          title,
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 14,
            color: enabled ? Design.lightGray : Design.lighterGray,
          ),
        ),
      ],
    );
  }
}
