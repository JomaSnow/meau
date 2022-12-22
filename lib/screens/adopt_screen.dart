import 'package:app/api/pet_functions.dart';
import 'package:app/models/pet_model.dart';
import 'package:app/util/design.dart';
import 'package:app/widgets/loading.dart';
import 'package:app/widgets/pet_card.dart';
import 'package:flutter/material.dart';

import '../widgets/page_template.dart';

class AdoptScreen extends StatefulWidget {
  const AdoptScreen({super.key});

  @override
  State<AdoptScreen> createState() => _AdoptScreenState();
}

class _AdoptScreenState extends State<AdoptScreen> {
  List<PetModel> petsList = [];
  bool loading = true;

  @override
  void initState() {
    setPets();
    super.initState();
  }

  void setPets() async {
    List<PetModel> pets = await getAllPets();
    setState(() {
      petsList = pets;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: "Adotar",
      appBarBackgroundColor: Design.primaryYellow,
      children: [
        Column(
          children: petsList.map((pet) => PetCard(pet: pet)).toList(),
        ),
        loading
            ? const Center(child: Loading())
            : const SizedBox(
                height: 20,
              ),
      ],
    );
  }
}
