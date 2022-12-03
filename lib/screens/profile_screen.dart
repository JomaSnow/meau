import 'dart:developer';

import 'package:app/api/user_functions.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screens/adopt_stories_screen.dart';
import 'package:app/screens/chat_screen.dart';
import 'package:app/screens/intro_screen.dart';
import 'package:app/util/design.dart';
import 'package:app/util/dismiss_focus.dart';
import 'package:app/util/validations.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/custom_paragraph.dart';
import 'package:app/widgets/error_message.dart';
import 'package:app/widgets/image_picker_button.dart';
import 'package:app/widgets/input.dart';
import 'package:app/widgets/label.dart';
import 'package:app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/page_template.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.user,
    required this.isProfileOwner,
  });

  final UserModel user;
  final bool isProfileOwner;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nomeController = TextEditingController();
  final idadeController = TextEditingController();
  final emailController = TextEditingController();
  final estadoController = TextEditingController();
  final cidadeController = TextEditingController();
  final enderecoController = TextEditingController();
  final telefoneController = TextEditingController();
  final usernameController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _updateFormKey = GlobalKey<FormState>();

  bool isEditing = false;
  bool loading = false;
  String imageErrorMessage = "";
  String errorMessage = "";
  Uint8List? imageBytes;

  @override
  void initState() {
    imageBytes = widget.user.image;
    super.initState();
  }

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

  void _handleUpdate() async {
    String updateErr = "";
    dismissFocus(context);
    setState(() {
      errorMessage = "";
      imageErrorMessage = "";
      loading = true;
    });

    if (_updateFormKey.currentState!.validate()) {
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

      UserModel? usr = await getUserByUsername(usernameController.text.trim());
      if (usr!.username != "") {
        setState(() {
          errorMessage =
              "Este nome de usuário já está sendo utilizado.\nEscolha outro nome de usuário.";
          loading = false;
        });
        return;
      }

      UpdateUserModel updatedUser = UpdateUserModel(
        nomeController.text.trim(),
        idadeController.text.trim(),
        widget.user.email,
        estadoController.text.trim().toUpperCase(),
        cidadeController.text.trim(),
        enderecoController.text.trim(),
        telefoneController.text.trim(),
        usernameController.text.trim(),
        imageBytes!,
      );

      updateErr = await updateUser(widget.user.id, updatedUser);

      if (updateErr.isEmpty) {
        if (!mounted) return;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const IntroScreen(),
            ));
      }
    } else {
      if (updateErr.isNotEmpty) {
        setState(() {
          errorMessage = updateErr;
        });
      }
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _updateFormKey,
      child: PageTemplate(
        title: widget.isProfileOwner ? "Meu perfil" : widget.user.nome,
        showDrawer: widget.isProfileOwner,
        horizontalPadding: 32,
        children: [
          isEditing
              ? ImagePickerButton(
                  imageBytes: imageBytes,
                  error: imageErrorMessage,
                  pickImage: _pickImage,
                  deleteImage: _deleteImage)
              : Container(
                  height: 112,
                  width: 112,
                  margin: const EdgeInsets.only(top: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.memory(
                      widget.user.image!,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              widget.user.nome,
              style: const TextStyle(
                  color: Design.darkerGray,
                  fontSize: 16,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500),
            ),
          ),
          Column(
            children: [
              const Label(
                margin: EdgeInsets.only(bottom: 6, top: 24),
                text: "NOME COMPLETO",
              ),
              isEditing
                  ? Input(
                      validationAction: (String? value) {
                        return UpdateValidations.validateName(value);
                      },
                      controller: nomeController,
                      styleColor: Design.lightBlue,
                      placeholder: widget.user.nome,
                    )
                  : CustomParagraph(value: widget.user.nome),
            ],
          ),
          Column(
            children: [
              const Label(
                margin: EdgeInsets.only(bottom: 6, top: 24),
                text: "IDADE",
              ),
              isEditing
                  ? Input(
                      validationAction: (String? value) {
                        return UpdateValidations.validateIdade(value);
                      },
                      controller: idadeController,
                      styleColor: Design.lightBlue,
                      placeholder: widget.user.idade,
                      type: TextInputType.number,
                    )
                  : CustomParagraph(value: "${widget.user.idade} anos"),
            ],
          ),
          Column(
            children: [
              const Label(
                margin: EdgeInsets.only(bottom: 6, top: 24),
                text: "EMAIL",
              ),
              CustomParagraph(value: widget.user.email),
            ],
          ),
          isEditing
              ? Column(
                  children: [
                    const Label(
                      margin: EdgeInsets.only(bottom: 6, top: 24),
                      text: "ESTADO",
                    ),
                    Input(
                      validationAction: (String? value) {
                        return UpdateValidations.validateEstado(value);
                      },
                      controller: estadoController,
                      styleColor: Design.lightBlue,
                      placeholder: widget.user.estado,
                    ),
                    const Label(
                      margin: EdgeInsets.only(bottom: 6, top: 24),
                      text: "CIDADE",
                    ),
                    Input(
                      validationAction: (String? value) {
                        return UpdateValidations.validateCidade(value);
                      },
                      controller: cidadeController,
                      styleColor: Design.lightBlue,
                      placeholder: widget.user.cidade,
                    ),
                  ],
                )
              : Column(
                  children: [
                    const Label(
                      margin: EdgeInsets.only(bottom: 6, top: 24),
                      text: "LOCALIZAÇÃO",
                    ),
                    CustomParagraph(
                        value: "${widget.user.cidade} - ${widget.user.estado}"),
                  ],
                ),
          Column(
            children: [
              const Label(
                margin: EdgeInsets.only(bottom: 6, top: 24),
                text: "ENDEREÇO",
              ),
              isEditing
                  ? Input(
                      validationAction: (String? value) {
                        return UpdateValidations.validateEndereco(value);
                      },
                      controller: enderecoController,
                      styleColor: Design.lightBlue,
                      placeholder: widget.user.endereco,
                    )
                  : CustomParagraph(value: widget.user.endereco),
            ],
          ),
          Column(
            children: [
              const Label(
                margin: EdgeInsets.only(bottom: 6, top: 24),
                text: "TELEFONE",
              ),
              isEditing
                  ? Input(
                      validationAction: (String? value) {
                        return UpdateValidations.validateTelefone(value);
                      },
                      controller: telefoneController,
                      styleColor: Design.lightBlue,
                      placeholder: widget.user.telefone,
                      type: TextInputType.phone,
                    )
                  : CustomParagraph(value: widget.user.telefone),
            ],
          ),
          Column(
            children: [
              const Label(
                margin: EdgeInsets.only(bottom: 6, top: 24),
                text: "NOME DE USUÁRIO",
              ),
              isEditing
                  ? Input(
                      validationAction: (String? value) {
                        return UpdateValidations.validateUsername(value);
                      },
                      controller: usernameController,
                      styleColor: Design.lightBlue,
                      placeholder: widget.user.username,
                    )
                  : CustomParagraph(value: widget.user.username),
            ],
          ),
          isEditing
              ? Container()
              : Column(
                  children: const [
                    Label(
                      margin: EdgeInsets.only(bottom: 6, top: 24),
                      text: "HISTÓRICO",
                    ),
                    CustomParagraph(value: "null"),
                  ],
                ),
          loading ? const Loading() : ErrorMessage(errorMessage: errorMessage),
          widget.isProfileOwner
              ? isEditing
                  ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Button(
                              value: "CANCELAR",
                              disabled: loading,
                              width: 148,
                              color: Design.lighterGray,
                              onPressed: () {
                                setState(() {
                                  isEditing = false;
                                });
                              }),
                          Button(
                              value: "SALVAR MUDANÇAS",
                              disabled: loading,
                              width: 148,
                              color: Design.lightBlue,
                              onPressed: _handleUpdate),
                        ],
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      child: Button(
                          value: "EDITAR PERFIL",
                          width: 148,
                          color: Design.lightBlue,
                          onPressed: () {
                            setState(() {
                              isEditing = true;
                            });
                          }),
                    )
              : Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Button(
                          value: "CHAT",
                          width: 148,
                          color: Design.lightBlue,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChatScreen(),
                              ),
                            );
                          }),
                      Button(
                          value: "HISTÓRIAS",
                          width: 148,
                          color: Design.lightBlue,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AdoptStoriesScreen(),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
