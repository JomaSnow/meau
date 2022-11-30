import 'package:app/util/design.dart';
import 'package:flutter/material.dart';
import '../widgets/page_template.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageTemplate(
      title: "Ajudar",
      appBarBackgroundColor: Design.primaryYellow,
      children: [],
    );
  }
}
