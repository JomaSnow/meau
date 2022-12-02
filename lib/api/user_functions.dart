import 'dart:developer';
import 'package:app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

bool isLoggedIn() {
  return FirebaseAuth.instance.currentUser?.uid != null;
}

Future<UserModel> getUser(String uid) async {
  UserModel user = UserModel();

  try {
    DocumentSnapshot<Map<String, dynamic>> docRef =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    user.id = uid;
    user.email = docRef.get("email");
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

Future<UserModel?> getUserByUsername(String username) async {
  UserModel user = UserModel();

  try {
    QuerySnapshot<Map<String, dynamic>> queryResult = await FirebaseFirestore
        .instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();

    QueryDocumentSnapshot<Map<String, dynamic>> doc = queryResult.docs.single;

    user.id = doc.id;
    user.email = doc.get("email");
    user.idade = doc.get("idade");
    user.cidade = doc.get("cidade");
    user.telefone = doc.get("telefone");
    user.estado = doc.get("estado");
    user.endereco = doc.get("endereco");
    user.nome = doc.get("nome");
    user.username = doc.get("username");
  } catch (e) {
    log(e.toString());
  }

  return user;
}

Future<UserModel?> getUserByEmail(String email) async {
  UserModel user = UserModel();

  try {
    QuerySnapshot<Map<String, dynamic>> queryResult = await FirebaseFirestore
        .instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get();

    QueryDocumentSnapshot<Map<String, dynamic>> doc = queryResult.docs.single;

    user.id = doc.id;
    user.email = doc.get("email");
    user.idade = doc.get("idade");
    user.cidade = doc.get("cidade");
    user.telefone = doc.get("telefone");
    user.estado = doc.get("estado");
    user.endereco = doc.get("endereco");
    user.nome = doc.get("nome");
    user.username = doc.get("username");
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
      String loginEmail = emailAddress;

      if (!emailAddress.trim().contains("@")) {
        try {
          UserModel? usr = await getUserByUsername(emailAddress);

          if (usr!.email != "") {
            loginEmail = usr.email;
          }
        } on FirebaseException catch (e) {
          return "Ocorreu um erro inesperado. ${e.code}";
        }
      }

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: loginEmail, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-email') {
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
        "email": user.email,
        "idade": user.idade,
        "estado": user.estado,
        "cidade": user.cidade,
        "endereco": user.endereco,
        "telefone": user.telefone,
        "username": user.username,
      });

      await FirebaseStorage.instance
          .ref()
          .child("images/profiles/${credential.user?.uid.toString()}")
          .putData(user.image);
    } on FirebaseException catch (e) {
      return e.code;
    }
  }
  return "";
}
