import 'dart:developer';

import 'package:app/models/pet_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> create(CreatePetModel pet) async {
  try {
    final doc = FirebaseFirestore.instance.collection("pets").doc();

    await doc.set({
      "nome": pet.nome,
      "especie": pet.especie,
      "sexo": pet.sexo,
      "porte": pet.porte,
      "idade": pet.idade,
      "temperamento": pet.temperamento,
      "saude": pet.saude,
      "doencas": pet.doencas,
      "exigenciasAdopt": pet.exigenciasAdopt,
      "exigenciasFoster": pet.exigenciasFoster,
      "necessidades": pet.necessidades,
      "medicamento": pet.medicamento,
      "objetos": pet.objetos,
      "sobre": pet.sobre,
      "ownerId": pet.ownerId,
      "isAdopt": pet.isAdopt,
      "isFoster": pet.isFoster,
      "isHelp": pet.isHelp,
    });

    final storageRef = FirebaseStorage.instance.ref();

    for (var img in pet.imgArr) {
      try {
        await storageRef
            .child("images/pets/${doc.id}/${doc.id}_${pet.imgArr.indexOf(img)}")
            .putData(img!);
      } on FirebaseException catch (e) {
        return e.code;
      }
    }
  } on FirebaseException catch (e) {
    log(e.code);
    return e.code;
  }

  return "";
}
