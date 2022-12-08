import 'dart:developer';

import 'package:app/models/pet_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<PetModel> getPet(String uid) async {
  PetModel pet = PetModel();
  const oneMegaByte = 1024 * 1024;

  try {
    DocumentSnapshot<Map<String, dynamic>> docRef =
        await FirebaseFirestore.instance.collection("pets").doc(uid).get();

    pet.id = uid;
    pet.nome = docRef.get("nome");
    pet.especie = docRef.get("especie");
    pet.sexo = docRef.get("sexo");
    pet.porte = docRef.get("porte");
    pet.idade = docRef.get("idade");
    pet.temperamento = docRef.get("temperamento");
    pet.saude = docRef.get("saude");
    pet.doencas = docRef.get("doencas");
    pet.exigenciasAdopt = docRef.get("exigenciasAdopt");
    pet.exigenciasFoster = docRef.get("exigenciasFoster");
    pet.necessidades = docRef.get("necessidades");
    pet.medicamento = docRef.get("medicamento");
    pet.objetos = docRef.get("objetos");
    pet.sobre = docRef.get("sobre");
    pet.ownerId = docRef.get("ownerId");
    pet.isAdopt = docRef.get("isAdopt");
    pet.isFoster = docRef.get("isFoster");
    pet.isHelp = docRef.get("isHelp");
    pet.imgArr = [];

    final images = await FirebaseStorage.instance
        .ref()
        .child("images/pets/$uid/")
        .listAll();

    log(images.items.toString());
    for (var img in images.items) {
      pet.imgArr!.add(await img.getData(4 * oneMegaByte));
    }
  } catch (e) {
    log(e.toString());
  }

  return pet;
}

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
