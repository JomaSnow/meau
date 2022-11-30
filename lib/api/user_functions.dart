import 'dart:developer';
import 'package:app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

bool isLoggedIn() {
  return FirebaseAuth.instance.currentUser?.uid != null;
}

Future<String> signIn(String emailAddress, String password) async {
  if (isLoggedIn()) {
    return "Já existe um usuário logado.";
  } else {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return "Usuário ou senha incorretos.";
      } else {
        return "Ocorreu um erro inesperado. ${e.code}";
      }
    }
  }
  return "";
}

Future<String> signOff() async {
  if (!isLoggedIn()) {
    log("Nenhum usuário para deslogar.");
    return "Nenhum usuário para deslogar.";
  } else {
    try {
      await FirebaseAuth.instance.signOut();
      return "";
    } on FirebaseAuthException catch (e) {
      return "Ocorreu um erro inesperado. ${e.code}";
    }
  }
}

Future<String> signUp(CreateUserModel user) async {
  if (isLoggedIn()) {
    return "Já existe um usuário logado. Faça logout antes.";
  } else {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email, password: user.password);

      await FirebaseFirestore.instance
          .collection("users")
          .doc(credential.user?.uid.toString())
          .set({
        "nome": user.nome,
        "idade": user.idade,
        "estado": user.estado,
        "cidade": user.cidade,
        "endereco": user.endereco,
        "telefone": user.telefone,
        "username": user.username,
      });
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }
  return "";
}
