import 'package:flutter/material.dart';
import '../util/design.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, this.size = 20.0});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size,
      height: size,
      child: const Center(
        child: CircularProgressIndicator(
            color: Design.lightBlue,
            strokeWidth: 4,
            backgroundColor: Design.accentBlue),
      ),
    );
  }
}
