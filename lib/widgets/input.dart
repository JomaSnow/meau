import 'package:app/util/design.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    required this.controller,
    this.styleColor = Design.primaryYellow,
    this.isPassword = false,
    this.placeholder = "",
    this.type = TextInputType.text,
    this.validationAction = _defaultValidate,
  });
  final TextEditingController controller;
  final Color styleColor;
  final bool isPassword;
  final String placeholder;
  final TextInputType type;
  final String? Function(String?) validationAction;

  static String? _defaultValidate(String? s) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
      child: TextFormField(
        obscureText: isPassword,
        validator: validationAction,
        keyboardType: type,
        controller: controller,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: "Roboto",
        ),
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Design.lighterGray)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: (styleColor),
          )),
          hintStyle: const TextStyle(
            color: Design.lighterGray,
          ),
          hintText: placeholder,
          contentPadding: const EdgeInsets.fromLTRB(5, 0, 10, -18),
        ),
      ),
    );
  }
}
