import 'dart:developer';

import 'package:app/models/pet_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> create(CreatePetModel pet) async {
  try {
    await FirebaseFirestore.instance.collection("pets").doc().set({
      "nome": pet.nome,
      "especie": pet.especie,
      "sexo": pet.sexo,
      "porte": pet.porte,
      "idade": pet.idade,
      "temperamento": pet.temperamento,
      "saude": pet.saude,
      "doencas": pet.doencas,
      "exigencias": pet.exigencias,
      "sobre": pet.sobre,
      "ownerId": pet.ownerId,
      "isAdopt": pet.isAdopt,
      "isFoster": pet.isFoster,
      "isHelp": pet.isHelp,
    });
  } on FirebaseException catch (e) {
    log(e.code);
    return e.code;
  }

  return "";
}
