import 'dart:developer';

import 'package:app/api/user_functions.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screens/intro_screen.dart';
import 'package:app/util/design.dart';
import 'package:app/util/dismiss_focus.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/error_message.dart';
import 'package:app/widgets/input.dart';
import 'package:app/widgets/label.dart';
import 'package:app/widgets/loading.dart';
import 'package:app/widgets/notice_card.dart';
import 'package:app/widgets/page_template.dart';
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
  bool loading = false;

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
    String err = "";
    dismissFocus(context);
    setState(() {
      errorMessage = "";
      loading = true;
    });
    if (_validateFields()) {
      CreateUserModel newUser = CreateUserModel(
          nameController.text,
          idadeController.text,
          emailController.text,
          estadoController.text,
          cidadeController.text,
          enderecoController.text,
          telefoneController.text,
          usernameController.text,
          passwordController.text,
          passwordConfirmController.text);

      err = await signUp(newUser);

      if (err.isEmpty) {
        if (!mounted) return;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const IntroScreen(),
            ));
      }
    } else {
      if (err.isNotEmpty) {
        setState(() {
          errorMessage = err;
        });
      }
      log("not registered: $errorMessage");
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: "Cadastro Pessoal",
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      showDrawer: false,
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
                loading
                    ? const Loading()
                    : ErrorMessage(errorMessage: errorMessage),
                Button(
                  value: "FAZER CADASTRO",
                  disabled: loading,
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
    );
  }
}
