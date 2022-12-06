import 'package:flutter/material.dart';

class InputRadio extends StatelessWidget {
  const InputRadio({
    super.key,
    required this.groupValue,
    required this.valueArray,
    required this.onChanged,
    this.singleLine = false,
  });

  final List<String> valueArray;
  final String groupValue;
  final Function(String?) onChanged;
  final bool singleLine;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: valueArray
          .map((elem) => Row(
                mainAxisSize: singleLine ? MainAxisSize.max : MainAxisSize.min,
                children: [
                  Radio(
                      value: elem,
                      groupValue: groupValue,
                      onChanged: onChanged),
                  Text(elem),
                ],
              ))
          .toList(),
    );
  }
}
