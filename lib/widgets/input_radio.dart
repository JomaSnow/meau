import 'package:app/widgets/error_message.dart';
import 'package:flutter/material.dart';

import '../util/design.dart';

class InputRadio extends StatelessWidget {
  const InputRadio({
    super.key,
    required this.groupValue,
    this.error = "",
    this.enabled = true,
    required this.valueArray,
    required this.onChanged,
    this.singleLine = false,
  });

  final List<String> valueArray;
  final String groupValue;
  final String error;
  final bool enabled;
  final Function(String?) onChanged;
  final bool singleLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: valueArray
              .map((elem) => Row(
                    mainAxisSize:
                        singleLine ? MainAxisSize.max : MainAxisSize.min,
                    children: [
                      Radio(
                          value: elem,
                          activeColor: Design.primaryYellow,
                          groupValue: groupValue,
                          onChanged: enabled ? onChanged : null),
                      Text(
                        elem,
                        style: TextStyle(
                          decoration:
                              error.isEmpty ? null : TextDecoration.underline,
                          decorationColor: Colors.red,
                          fontFamily: "Roboto",
                          fontSize: 14,
                          color:
                              enabled ? Design.lightGray : Design.lighterGray,
                        ),
                      ),
                    ],
                  ))
              .toList(),
        ),
        error.isNotEmpty
            ? ErrorMessage(
                errorMessage: error,
              )
            : Container(),
      ],
    );
  }
}
