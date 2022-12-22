import 'package:flutter/services.dart';

class CreatePetModel {
  CreatePetModel(
    this.nome,
    this.especie,
    this.sexo,
    this.porte,
    this.idade,
    this.temperamento,
    this.saude,
    this.doencas,
    this.exigenciasAdopt,
    this.exigenciasFoster,
    this.necessidades,
    this.medicamento,
    this.objetos,
    this.sobre,
    this.ownerId,
    this.isAdopt,
    this.isFoster,
    this.isHelp,
    this.imgArr,
  );

  final String nome;
  final String especie;
  final String sexo;
  final String porte;
  final String idade;
  final String temperamento;
  final String saude;
  final String doencas;
  final String exigenciasAdopt;
  final String exigenciasFoster;
  final String necessidades;
  final String medicamento;
  final String objetos;
  final String sobre;
  final String ownerId;
  final bool isAdopt;
  final bool isFoster;
  final bool isHelp;
  final List<Uint8List?> imgArr;
}

class PetModel {
  PetModel({
    this.id = "",
    this.nome = "",
    this.especie = "",
    this.sexo = "",
    this.porte = "",
    this.idade = "",
    this.temperamento = "",
    this.saude = "",
    this.doencas = "",
    this.exigenciasAdopt = "",
    this.exigenciasFoster = "",
    this.necessidades = "",
    this.medicamento = "",
    this.objetos = "",
    this.sobre = "",
    this.ownerId = "",
    this.isAdopt = false,
    this.isFoster = false,
    this.isHelp = false,
    this.userAddress = "",
  });

  String id;
  String nome;
  String especie;
  String sexo;
  String porte;
  String idade;
  String temperamento;
  String saude;
  String doencas;
  String exigenciasAdopt;
  String exigenciasFoster;
  String necessidades;
  String medicamento;
  String objetos;
  String sobre;
  String ownerId;
  bool isAdopt;
  bool isFoster;
  bool isHelp;
  List<Uint8List?>? imgArr;
  String userAddress;
}
