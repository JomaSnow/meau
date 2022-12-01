import 'dart:developer';

import 'package:app/api/user_functions.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screens/intro_screen.dart';
import 'package:app/util/design.dart';
import 'package:app/util/dismiss_focus.dart';
import 'package:app/util/validations.dart';
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
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  String errorMessage = "";
  bool loading = false;

  void _handleRegister(BuildContext context) async {
    String err = "";
    dismissFocus(context);
    setState(() {
      errorMessage = "";
      loading = true;
    });
    if (_registerFormKey.currentState!.validate()) {
      CreateUserModel newUser = CreateUserModel(
          nameController.text.trim(),
          idadeController.text.trim(),
          emailController.text.trim(),
          estadoController.text.trim().toUpperCase(),
          cidadeController.text.trim(),
          enderecoController.text.trim(),
          telefoneController.text.trim(),
          usernameController.text.trim(),
          passwordController.text.trim(),
          passwordConfirmController.text.trim());

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
        Form(
          key: _registerFormKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Input(
                controller: nameController,
                validationAction: (String? value) {
                  return RegisterValidations.validateName(value);
                },
                type: TextInputType.name,
                placeholder: "Nome Completo",
                styleColor: Design.lightBlue,
              ),
              Input(
                controller: idadeController,
                validationAction: (String? value) {
                  return RegisterValidations.validateIdade(value);
                },
                type: TextInputType.number,
                placeholder: "Idade",
                styleColor: Design.lightBlue,
              ),
              Input(
                controller: emailController,
                validationAction: (String? value) {
                  return RegisterValidations.validateEmail(value);
                },
                type: TextInputType.emailAddress,
                placeholder: "E-mail",
                styleColor: Design.lightBlue,
              ),
              Input(
                controller: estadoController,
                validationAction: (String? value) {
                  return RegisterValidations.validateEstado(value);
                },
                type: TextInputType.streetAddress,
                placeholder: "Estado",
                styleColor: Design.lightBlue,
              ),
              Input(
                controller: cidadeController,
                validationAction: (String? value) {
                  return RegisterValidations.validateCidade(value);
                },
                type: TextInputType.streetAddress,
                placeholder: "Cidade",
                styleColor: Design.lightBlue,
              ),
              Input(
                controller: enderecoController,
                validationAction: (String? value) {
                  return RegisterValidations.validateEndereco(value);
                },
                type: TextInputType.streetAddress,
                placeholder: "Endereço",
                styleColor: Design.lightBlue,
              ),
              Input(
                controller: telefoneController,
                validationAction: (String? value) {
                  return RegisterValidations.validateTelefone(value);
                },
                type: TextInputType.phone,
                placeholder: "Telefone",
                styleColor: Design.lightBlue,
              ),
              const Label(text: "INFORMAÇÕES DE PERFIL"),
              Input(
                controller: usernameController,
                validationAction: (String? value) {
                  return RegisterValidations.validateUsername(value);
                },
                type: TextInputType.text,
                placeholder: "Nome de usuário",
                styleColor: Design.lightBlue,
              ),
              Input(
                controller: passwordController,
                validationAction: (String? value) {
                  if (passwordController.text !=
                      passwordConfirmController.text) {
                    return "As senhas devem ser iguais.";
                  }
                  return RegisterValidations.validatePassword(value);
                },
                type: TextInputType.text,
                placeholder: "Senha",
                isPassword: true,
                styleColor: Design.lightBlue,
              ),
              Input(
                controller: passwordConfirmController,
                validationAction: (String? value) {
                  if (passwordController.text !=
                      passwordConfirmController.text) {
                    return "As senhas devem ser iguais.";
                  }
                  return RegisterValidations.validatePasswordConfirm(value);
                },
                type: TextInputType.text,
                placeholder: "Confirmação de senha",
                isPassword: true,
                styleColor: Design.lightBlue,
              ),
            ],
          ),
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
