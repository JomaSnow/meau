import 'package:app/util/design.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          color: Design.darkerGray,
          fontSize: 16,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w500),
    );
  }
}
