import 'package:flutter/services.dart';

class CreateUserModel {
  CreateUserModel(
    this.nome,
    this.idade,
    this.email,
    this.estado,
    this.cidade,
    this.endereco,
    this.telefone,
    this.username,
    this.password,
    this.passwordConfirm,
    this.image,
  );

  final String nome;
  final String idade;
  final String email;
  final String estado;
  final String cidade;
  final String endereco;
  final String telefone;
  final String username;
  final String password;
  final String passwordConfirm;
  final Uint8List image;
}

class UpdateUserModel {
  UpdateUserModel(
    this.nome,
    this.idade,
    this.email,
    this.estado,
    this.cidade,
    this.endereco,
    this.telefone,
    this.username,
    this.image,
  );

  final String nome;
  final String idade;
  final String email;
  final String estado;
  final String cidade;
  final String endereco;
  final String telefone;
  final String username;
  final Uint8List image;
}

class UserModel {
  UserModel({
    this.id = "",
    this.nome = "",
    this.idade = "",
    this.email = "",
    this.estado = "",
    this.cidade = "",
    this.endereco = "",
    this.telefone = "",
    this.username = "",
  });

  String id;
  String nome;
  String idade;
  String email;
  String estado;
  String cidade;
  String endereco;
  String telefone;
  String username;
  Uint8List? image;
}
