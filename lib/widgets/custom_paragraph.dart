import 'package:app/util/design.dart';
import 'package:flutter/widgets.dart';

class CustomParagraph extends StatelessWidget {
  const CustomParagraph({super.key, required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        value,
        style: const TextStyle(
            fontFamily: "Roboto", fontSize: 14, color: Design.lightGray),
        textAlign: TextAlign.center,
      ),
    );
  }
}
