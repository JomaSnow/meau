import 'package:app/util/design.dart';
import 'package:flutter/widgets.dart';

class IntroParagraph extends StatelessWidget {
  const IntroParagraph({super.key, required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(
          fontFamily: "Roboto", fontSize: 14, color: Design.lightGray),
      textAlign: TextAlign.center,
    );
  }
}
