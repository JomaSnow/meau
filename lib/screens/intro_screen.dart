import 'package:app/util/design.dart';
import 'package:app/widgets/intro_title.dart';
import 'package:flutter/widgets.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Design.white,
      child: Column(
        children: const [IntroTitle(title: "Olá!")],
      ),
    );
  }
}
