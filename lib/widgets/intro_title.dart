import 'package:app/util/design.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroTitle extends StatelessWidget {
  const IntroTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 56, 0, 54),
      child: Text(
        title,
        style: const TextStyle(color: Design.primaryYellow, fontSize: 30),
      ),
    );
  }
}
