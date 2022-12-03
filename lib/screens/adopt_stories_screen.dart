import 'package:flutter/material.dart';
import '../widgets/page_template.dart';

class AdoptStoriesScreen extends StatelessWidget {
  const AdoptStoriesScreen({super.key});

  // Se não existe histórias, rendereizar tela de ops (Perfil)

  @override
  Widget build(BuildContext context) {
    return const PageTemplate(
      title: "Histórias de Adoção",
      children: [],
    );
  }
}
