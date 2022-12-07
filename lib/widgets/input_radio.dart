import 'package:flutter/material.dart';

import '../util/design.dart';

class InputRadio extends StatelessWidget {
  const InputRadio({
    super.key,
    required this.groupValue,
    this.enabled = true,
    required this.valueArray,
    required this.onChanged,
    this.singleLine = false,
  });

  final List<String> valueArray;
  final String groupValue;
  final bool enabled;
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
                      activeColor: Design.primaryYellow,
                      groupValue: groupValue,
                      onChanged: enabled ? onChanged : null),
                  Text(
                    elem,
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 14,
                      color: enabled ? Design.lightGray : Design.lighterGray,
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }
}
