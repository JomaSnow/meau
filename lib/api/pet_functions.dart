import 'dart:developer';

import 'package:app/api/user_functions.dart';
import 'package:app/models/pet_model.dart';
import 'package:app/models/user_model.dart';
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

Future<List<PetModel>> getAllPets() async {
  List<PetModel> pets = [];
  const oneMegaByte = 1024 * 1024;

  try {
    QuerySnapshot<Map<String, dynamic>> docsRef =
        await FirebaseFirestore.instance.collection("pets").get();

    for (var doc in docsRef.docs) {
      PetModel pet = PetModel();
      UserModel owner = UserModel();

      pet.id = doc.id;
      pet.nome = doc.get("nome");
      pet.especie = doc.get("especie");
      pet.sexo = doc.get("sexo");
      pet.porte = doc.get("porte");
      pet.idade = doc.get("idade");
      pet.temperamento = doc.get("temperamento");
      pet.saude = doc.get("saude");
      pet.doencas = doc.get("doencas");
      pet.exigenciasAdopt = doc.get("exigenciasAdopt");
      pet.exigenciasFoster = doc.get("exigenciasFoster");
      pet.necessidades = doc.get("necessidades");
      pet.medicamento = doc.get("medicamento");
      pet.objetos = doc.get("objetos");
      pet.sobre = doc.get("sobre");
      pet.ownerId = doc.get("ownerId");
      pet.isAdopt = doc.get("isAdopt");
      pet.isFoster = doc.get("isFoster");
      pet.isHelp = doc.get("isHelp");
      pet.imgArr = [];

      owner = await getUser(pet.ownerId);

      pet.userAddress = "${owner.cidade} - ${owner.estado}";

      ListResult images = await FirebaseStorage.instance
          .ref()
          .child("images/pets/${doc.id}/")
          .listAll();

      log(images.items.toString());
      for (var img in images.items) {
        pet.imgArr!.add(await img.getData(4 * oneMegaByte));
      }

      pets.add(pet);
    }
  } catch (e) {
    log(e.toString());
  }

  return pets;
}

Future<List<PetModel>> getAllPetsForAdoption() async {
  List<PetModel> pets = [];
  const oneMegaByte = 1024 * 1024;

  try {
    QuerySnapshot<Map<String, dynamic>> docsRef = await FirebaseFirestore
        .instance
        .collection("pets")
        .where("isAdopt", isEqualTo: true)
        .get();

    for (var doc in docsRef.docs) {
      PetModel pet = PetModel();
      UserModel owner = UserModel();

      pet.id = doc.id;
      pet.nome = doc.get("nome");
      pet.especie = doc.get("especie");
      pet.sexo = doc.get("sexo");
      pet.porte = doc.get("porte");
      pet.idade = doc.get("idade");
      pet.temperamento = doc.get("temperamento");
      pet.saude = doc.get("saude");
      pet.doencas = doc.get("doencas");
      pet.exigenciasAdopt = doc.get("exigenciasAdopt");
      pet.exigenciasFoster = doc.get("exigenciasFoster");
      pet.necessidades = doc.get("necessidades");
      pet.medicamento = doc.get("medicamento");
      pet.objetos = doc.get("objetos");
      pet.sobre = doc.get("sobre");
      pet.ownerId = doc.get("ownerId");
      pet.isAdopt = doc.get("isAdopt");
      pet.isFoster = doc.get("isFoster");
      pet.isHelp = doc.get("isHelp");
      pet.imgArr = [];

      owner = await getUser(pet.ownerId);

      pet.userAddress = "${owner.cidade} - ${owner.estado}";

      ListResult images = await FirebaseStorage.instance
          .ref()
          .child("images/pets/${doc.id}/")
          .listAll();

      log(images.items.toString());
      for (var img in images.items) {
        pet.imgArr!.add(await img.getData(4 * oneMegaByte));
      }

      pets.add(pet);
    }
  } catch (e) {
    log(e.toString());
  }

  return pets;
}

Future<List<PetModel>> getAllPetsByUser(String uid) async {
  List<PetModel> pets = [];
  const oneMegaByte = 1024 * 1024;

  try {
    QuerySnapshot<Map<String, dynamic>> docsRef = await FirebaseFirestore
        .instance
        .collection("pets")
        .where("ownerId", isEqualTo: uid)
        .get();

    for (var doc in docsRef.docs) {
      PetModel pet = PetModel();
      UserModel owner = UserModel();

      pet.id = doc.id;
      pet.nome = doc.get("nome");
      pet.especie = doc.get("especie");
      pet.sexo = doc.get("sexo");
      pet.porte = doc.get("porte");
      pet.idade = doc.get("idade");
      pet.temperamento = doc.get("temperamento");
      pet.saude = doc.get("saude");
      pet.doencas = doc.get("doencas");
      pet.exigenciasAdopt = doc.get("exigenciasAdopt");
      pet.exigenciasFoster = doc.get("exigenciasFoster");
      pet.necessidades = doc.get("necessidades");
      pet.medicamento = doc.get("medicamento");
      pet.objetos = doc.get("objetos");
      pet.sobre = doc.get("sobre");
      pet.ownerId = doc.get("ownerId");
      pet.isAdopt = doc.get("isAdopt");
      pet.isFoster = doc.get("isFoster");
      pet.isHelp = doc.get("isHelp");
      pet.imgArr = [];

      owner = await getUser(pet.ownerId);

      pet.userAddress = "${owner.cidade} - ${owner.estado}";

      ListResult images = await FirebaseStorage.instance
          .ref()
          .child("images/pets/${doc.id}/")
          .listAll();

      log(images.items.toString());
      for (var img in images.items) {
        pet.imgArr!.add(await img.getData(4 * oneMegaByte));
      }

      pets.add(pet);
    }
  } catch (e) {
    log(e.toString());
  }

  return pets;
}

Future<List<PetModel>> getAllPetsForFoster() async {
  List<PetModel> pets = [];
  const oneMegaByte = 1024 * 1024;

  try {
    QuerySnapshot<Map<String, dynamic>> docsRef = await FirebaseFirestore
        .instance
        .collection("pets")
        .where("isFoster", isEqualTo: true)
        .get();

    for (var doc in docsRef.docs) {
      PetModel pet = PetModel();
      UserModel owner = UserModel();

      pet.id = doc.id;
      pet.nome = doc.get("nome");
      pet.especie = doc.get("especie");
      pet.sexo = doc.get("sexo");
      pet.porte = doc.get("porte");
      pet.idade = doc.get("idade");
      pet.temperamento = doc.get("temperamento");
      pet.saude = doc.get("saude");
      pet.doencas = doc.get("doencas");
      pet.exigenciasAdopt = doc.get("exigenciasAdopt");
      pet.exigenciasFoster = doc.get("exigenciasFoster");
      pet.necessidades = doc.get("necessidades");
      pet.medicamento = doc.get("medicamento");
      pet.objetos = doc.get("objetos");
      pet.sobre = doc.get("sobre");
      pet.ownerId = doc.get("ownerId");
      pet.isAdopt = doc.get("isAdopt");
      pet.isFoster = doc.get("isFoster");
      pet.isHelp = doc.get("isHelp");
      pet.imgArr = [];

      owner = await getUser(pet.ownerId);

      pet.userAddress = "${owner.cidade} - ${owner.estado}";

      ListResult images = await FirebaseStorage.instance
          .ref()
          .child("images/pets/${doc.id}/")
          .listAll();

      log(images.items.toString());
      for (var img in images.items) {
        pet.imgArr!.add(await img.getData(4 * oneMegaByte));
      }

      pets.add(pet);
    }
  } catch (e) {
    log(e.toString());
  }

  return pets;
}

Future<List<PetModel>> getAllPetsForHelp() async {
  List<PetModel> pets = [];
  const oneMegaByte = 1024 * 1024;

  try {
    QuerySnapshot<Map<String, dynamic>> docsRef = await FirebaseFirestore
        .instance
        .collection("pets")
        .where("isHelp", isEqualTo: true)
        .get();

    for (var doc in docsRef.docs) {
      PetModel pet = PetModel();
      UserModel owner = UserModel();

      pet.id = doc.id;
      pet.nome = doc.get("nome");
      pet.especie = doc.get("especie");
      pet.sexo = doc.get("sexo");
      pet.porte = doc.get("porte");
      pet.idade = doc.get("idade");
      pet.temperamento = doc.get("temperamento");
      pet.saude = doc.get("saude");
      pet.doencas = doc.get("doencas");
      pet.exigenciasAdopt = doc.get("exigenciasAdopt");
      pet.exigenciasFoster = doc.get("exigenciasFoster");
      pet.necessidades = doc.get("necessidades");
      pet.medicamento = doc.get("medicamento");
      pet.objetos = doc.get("objetos");
      pet.sobre = doc.get("sobre");
      pet.ownerId = doc.get("ownerId");
      pet.isAdopt = doc.get("isAdopt");
      pet.isFoster = doc.get("isFoster");
      pet.isHelp = doc.get("isHelp");
      pet.imgArr = [];

      owner = await getUser(pet.ownerId);

      pet.userAddress = "${owner.cidade} - ${owner.estado}";

      ListResult images = await FirebaseStorage.instance
          .ref()
          .child("images/pets/${doc.id}/")
          .listAll();

      log(images.items.toString());
      for (var img in images.items) {
        pet.imgArr!.add(await img.getData(4 * oneMegaByte));
      }

      pets.add(pet);
    }
  } catch (e) {
    log(e.toString());
  }

  return pets;
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
