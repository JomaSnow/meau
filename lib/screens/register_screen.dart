import 'dart:async';
import 'dart:developer';

import 'package:app/screens/intro_screen.dart';
import 'package:app/util/design.dart';
import 'package:app/util/dismiss_focus.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/custom_app_bar.dart';
import 'package:app/widgets/error_message.dart';
import 'package:app/widgets/input.dart';
import 'package:app/widgets/label.dart';
import 'package:app/widgets/notice_card.dart';
import 'package:app/widgets/scrollable_container.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();

  final idadeController = TextEditingController();

  final emailController = TextEditingController();

  final estadoController = TextEditingController();

  final cidadeController = TextEditingController();

  final enderecoController = TextEditingController();

  final telefoneController = TextEditingController();

  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final passwordConfirmController = TextEditingController();

  String errorMessage = "";

  bool _validateFields() {
    // password at least 6 characters long
    if (passwordController.text.length < 6) {
      setState(() {
        errorMessage = "Senha deve conter pelo menos 6 caracteres.";
      });
      return false;
    }

    // passwords match
    if (passwordController.text != passwordConfirmController.text) {
      setState(() {
        errorMessage = "Senhas não são iguais.";
      });
      return false;
    }

    return true;
  }

  void _handleRegister(BuildContext context) async {
    dismissFocus(context);
    setState(() {
      errorMessage = "";
    });
    if (_validateFields()) {
      // MOCK: implement firebase register function
      await Future.delayed(const Duration(seconds: 4), () {
        log("registered");
      });
      if (!mounted) return;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => IntroScreen(),
          ));
    } else {
      //MOCK: signal field errors
      log("not registered: $errorMessage");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(
        title: "Cadastro Pessoal",
      ),
      body: ScrollableContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const NoticeCard(
              text:
                  "As informações preenchidas serão divulgadas apenas para a pessoa com a qual você realizar o processo de adoção e/ou apadrinhamento, após a formalização do processo.",
            ),
            const Label(text: "INFORMAÇÕES PESSOAIS"),
            Input(
              controller: nameController,
              placeholder: "Nome Completo",
              styleColor: Design.lightBlue,
            ),
            Input(
              controller: idadeController,
              placeholder: "Idade",
              styleColor: Design.lightBlue,
            ),
            Input(
              controller: emailController,
              placeholder: "E-mail",
              styleColor: Design.lightBlue,
            ),
            Input(
              controller: estadoController,
              placeholder: "Estado",
              styleColor: Design.lightBlue,
            ),
            Input(
              controller: cidadeController,
              placeholder: "Cidade",
              styleColor: Design.lightBlue,
            ),
            Input(
              controller: enderecoController,
              placeholder: "Endereço",
              styleColor: Design.lightBlue,
            ),
            Input(
              controller: telefoneController,
              placeholder: "Telefone",
              styleColor: Design.lightBlue,
            ),
            const Label(text: "INFORMAÇÕES DE PERFIL"),
            Input(
              controller: usernameController,
              placeholder: "Nome de usuário",
              styleColor: Design.lightBlue,
            ),
            Input(
              controller: passwordController,
              placeholder: "Senha",
              isPassword: true,
              styleColor: Design.lightBlue,
            ),
            Input(
              controller: passwordConfirmController,
              placeholder: "Confirmação de senha",
              isPassword: true,
              styleColor: Design.lightBlue,
            ),
            const Label(
              text: "FOTO DE PERFIL",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Label(
                      text: "insert ImagePicker custom widget",
                      color: Colors.red,
                    ),
                    ErrorMessage(errorMessage: errorMessage),
                    Button(
                      value: "FAZER CADASTRO",
                      onPressed: () {
                        _handleRegister(context);
                      },
                      width: 240,
                      color: Design.lightBlue,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
