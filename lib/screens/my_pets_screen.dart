import 'package:app/api/pet_functions.dart';
import 'package:app/models/pet_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/widgets/loading.dart';
import 'package:app/widgets/pet_card.dart';
import 'package:flutter/material.dart';
import '../widgets/page_template.dart';

class MyPetsScreen extends StatefulWidget {
  const MyPetsScreen({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  State<MyPetsScreen> createState() => _MyPetsScreenState();
}

class _MyPetsScreenState extends State<MyPetsScreen> {
  List<PetModel> petsList = [];
  bool loading = true;

  @override
  void initState() {
    setPets();
    super.initState();
  }

  void setPets() async {
    List<PetModel> pets = await getAllPetsByUser(widget.user.id);
    setState(() {
      petsList = pets;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: "Meus Pets",
      children: [
        Column(
          children: petsList
              .map((pet) => PetCard(
                    pet: pet,
                    isOwner: true,
                  ))
              .toList(),
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
