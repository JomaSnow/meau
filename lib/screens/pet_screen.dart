import 'package:app/models/pet_model.dart';
import 'package:flutter/material.dart';
import '../widgets/page_template.dart';

class PetScreen extends StatelessWidget {
  const PetScreen({
    super.key,
    required this.pet,
  });

  final PetModel pet;

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: pet.nome,
      children: [
        Text(pet.id),
      ],
    );
  }
}
