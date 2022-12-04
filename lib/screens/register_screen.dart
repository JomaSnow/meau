import 'dart:developer';

import 'package:app/api/user_functions.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screens/intro_screen.dart';
import 'package:app/util/design.dart';
import 'package:app/util/dismiss_focus.dart';
import 'package:app/util/validations.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/error_message.dart';
import 'package:app/widgets/image_picker_button.dart';
import 'package:app/widgets/input_text.dart';
import 'package:app/widgets/label.dart';
import 'package:app/widgets/loading.dart';
import 'package:app/widgets/notice_card.dart';
import 'package:app/widgets/page_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

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

  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  String errorMessage = "";
  String imageErrorMessage = "";
  bool loading = false;
  Uint8List? imageBytes;

  void _pickImage() async {
    try {
      XFile? img = await _picker.pickImage(source: ImageSource.gallery);
      Uint8List bytes = await img!.readAsBytes();

      setState(() {
        imageBytes = bytes;
        imageErrorMessage = "";
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void _deleteImage() async {
    setState(() {
      imageBytes = null;
      imageErrorMessage = "";
    });
  }

  void _handleRegister(BuildContext context) async {
    String signupErr = "";
    dismissFocus(context);
    setState(() {
      errorMessage = "";
      imageErrorMessage = "";
      loading = true;
    });

    if (_registerFormKey.currentState!.validate()) {
      UserModel? usr;

      if (imageBytes == null) {
        setState(() {
          imageErrorMessage = "Selecione uma imagem.";
          loading = false;
        });
        return;
      }

      const int fileSizeLimitBytes = 4000000; // 4MB
      final int imageBytesSize = imageBytes!.length;
      final bool isValidSize = imageBytesSize < fileSizeLimitBytes;
      if (!isValidSize) {
        setState(() {
          imageErrorMessage = "Arquivo excede tamanho máximo (1MB).";
          loading = false;
        });
        return;
      }

      usr = await getUserByEmail(emailController.text.trim());

      if (usr!.email != "") {
        setState(() {
          errorMessage = "Já existe uma conta com este email.";
          loading = false;
        });
        return;
      }

      usr = await getUserByUsername(usernameController.text.trim());

      if (usr!.username != "") {
        setState(() {
          errorMessage =
              "Este nome de usuário já está sendo utilizado.\nEscolha outro nome de usuário.";
          loading = false;
        });
        return;
      }

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
        passwordConfirmController.text.trim(),
        imageBytes!,
      );

      signupErr = await signUp(newUser);

      if (signupErr.isEmpty) {
        if (!mounted) return;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const IntroScreen(),
            ));
      }
    } else {
      if (signupErr.isNotEmpty) {
        setState(() {
          errorMessage = signupErr;
        });
      }
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputText(
                controller: nameController,
                validationAction: (String? value) {
                  return RegisterValidations.validateName(value);
                },
                type: TextInputType.name,
                placeholder: "Nome Completo",
                styleColor: Design.lightBlue,
              ),
              InputText(
                controller: idadeController,
                validationAction: (String? value) {
                  return RegisterValidations.validateIdade(value);
                },
                type: TextInputType.number,
                placeholder: "Idade",
                styleColor: Design.lightBlue,
              ),
              InputText(
                controller: emailController,
                validationAction: (String? value) {
                  return RegisterValidations.validateEmail(value);
                },
                type: TextInputType.emailAddress,
                placeholder: "E-mail",
                styleColor: Design.lightBlue,
              ),
              InputText(
                controller: estadoController,
                validationAction: (String? value) {
                  return RegisterValidations.validateEstado(value);
                },
                type: TextInputType.streetAddress,
                placeholder: "Estado",
                styleColor: Design.lightBlue,
              ),
              InputText(
                controller: cidadeController,
                validationAction: (String? value) {
                  return RegisterValidations.validateCidade(value);
                },
                type: TextInputType.streetAddress,
                placeholder: "Cidade",
                styleColor: Design.lightBlue,
              ),
              InputText(
                controller: enderecoController,
                validationAction: (String? value) {
                  return RegisterValidations.validateEndereco(value);
                },
                type: TextInputType.streetAddress,
                placeholder: "Endereço",
                styleColor: Design.lightBlue,
              ),
              InputText(
                controller: telefoneController,
                validationAction: (String? value) {
                  return RegisterValidations.validateTelefone(value);
                },
                type: TextInputType.phone,
                placeholder: "Telefone",
                styleColor: Design.lightBlue,
              ),
              const Label(text: "INFORMAÇÕES DE PERFIL"),
              InputText(
                controller: usernameController,
                validationAction: (String? value) {
                  return RegisterValidations.validateUsername(value);
                },
                type: TextInputType.text,
                placeholder: "Nome de usuário",
                styleColor: Design.lightBlue,
              ),
              InputText(
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
              InputText(
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
                ImagePickerButton(
                    imageBytes: imageBytes,
                    error: imageErrorMessage,
                    pickImage: _pickImage,
                    deleteImage: _deleteImage),
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
