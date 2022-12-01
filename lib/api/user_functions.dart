import 'dart:developer';
import 'package:app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

bool isLoggedIn() {
  return FirebaseAuth.instance.currentUser?.uid != null;
}

Future<UserModel> getUser(String uid) async {
  UserModel user = UserModel();

  try {
    DocumentSnapshot<Map<String, dynamic>> docRef =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    user.id = uid;
    user.email = FirebaseAuth.instance.currentUser!.email!;
    user.idade = docRef.get("idade");
    user.cidade = docRef.get("cidade");
    user.telefone = docRef.get("telefone");
    user.estado = docRef.get("estado");
    user.endereco = docRef.get("endereco");
    user.nome = docRef.get("nome");
    user.username = docRef.get("username");
  } catch (e) {
    log(e.toString());
  }

  return user;
}

Future<UserModel?> getCurrentUser() async {
  UserModel? currentUser = UserModel();

  if (isLoggedIn()) {
    try {
      currentUser = await getUser(FirebaseAuth.instance.currentUser!.uid);
    } catch (e) {
      currentUser = null;
    }
  } else {
    currentUser = null;
  }

  return currentUser;
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
    } on FirebaseException catch (e) {
      return e.code;
    }
  }
  return "";
}
