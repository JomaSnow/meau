import 'package:flutter/material.dart';

class InputSingleCheckbox extends StatelessWidget {
  const InputSingleCheckbox({
    super.key,
    required this.onChanged,
    required this.value,
    required this.title,
    this.singleLine = false,
  });

  final Function(bool?) onChanged;
  final bool value;
  final String title;
  final bool singleLine;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: singleLine ? MainAxisSize.max : MainAxisSize.min,
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Text(title),
      ],
    );
  }
}
