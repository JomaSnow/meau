import 'package:app/util/design.dart';
import 'package:flutter/material.dart';
import '../widgets/page_template.dart';

class PetRegisterScreen extends StatelessWidget {
  const PetRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageTemplate(
      title: "Cadastro do Animal",
      appBarBackgroundColor: Design.primaryYellow,
      children: [],
    );
  }
}
