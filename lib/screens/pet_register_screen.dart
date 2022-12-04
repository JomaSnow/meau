import 'dart:developer';

import 'package:app/util/design.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/custom_paragraph.dart';
import 'package:app/widgets/image_picker_multiple_button.dart';
import 'package:app/widgets/input.dart';
import 'package:app/widgets/label.dart';
import 'package:app/widgets/pet_register_adopt.dart';
import 'package:app/widgets/pet_register_foster.dart';
import 'package:app/widgets/pet_register_help.dart';
import 'package:app/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user_model.dart';
import '../widgets/page_template.dart';

class PetRegisterScreen extends StatefulWidget {
  const PetRegisterScreen({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  State<PetRegisterScreen> createState() => _PetRegisterScreenState();
}

class _PetRegisterScreenState extends State<PetRegisterScreen> {
  final nomeController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  bool isAdopt = false;
  bool isFoster = false;
  bool isHelp = false;
  String imageErrorMessage = "";
  List<Uint8List?> imageBytes = [];

  void _pickImage() async {
    try {
      List<XFile?> imgArray = await _picker.pickMultiImage();
      List<Uint8List?> bytes = imageBytes;

      for (var img in imgArray) {
        bytes.add(await img!.readAsBytes());
      }

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
      imageBytes = [];
      imageErrorMessage = "";
    });
  }

  void _handleRegister() {}

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: "Cadastro do Animal",
      horizontalPadding: 30,
      appBarBackgroundColor: Design.primaryYellow,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 14, bottom: 0),
          child: const CustomParagraph(
              value: "Tenho interesse em cadastrar o animal para:"),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 6),
                child: Button(
                  value: "ADOTAR",
                  onPressed: () {
                    setState(() {
                      isAdopt = !isAdopt;
                    });
                  },
                  color: isAdopt ? Design.primaryYellow : Design.white2,
                  disabled: isFoster,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 6),
                child: Button(
                  value: "APADRINHAR",
                  onPressed: () {
                    setState(() {
                      isFoster = !isFoster;
                    });
                  },
                  color: isFoster ? Design.primaryYellow : Design.white1,
                  disabled: isAdopt,
                ),
              ),
            ),
            Expanded(
              child: Button(
                value: "AJUDA",
                onPressed: () {
                  setState(() {
                    isHelp = !isHelp;
                  });
                },
                color: isHelp ? Design.primaryYellow : Design.white1,
              ),
            ),
          ],
        ),
        isAdopt || isFoster || isHelp
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.only(top: 20),
                    width: 1000,
                    decoration: const BoxDecoration(
                      border: Border(
                          top:
                              BorderSide(color: Design.lightestGray, width: 1)),
                    ),
                    child: SectionTitle(
                        title: isAdopt
                            ? "Adoção"
                            : isFoster
                                ? "Apadrinhar"
                                : "Ajudar"),
                  ),
                  const Label(
                      text: "NOME DO ANIMAL",
                      margin: EdgeInsets.only(top: 20),
                      color: Design.primaryYellow),
                  Input(
                    controller: nomeController,
                    placeholder: "Nome do animal",
                  ),
                  const Label(
                      text: "FOTOS DO ANIMAL",
                      margin: EdgeInsets.only(top: 20),
                      color: Design.primaryYellow),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: ImagePickerMultipleButton(
                        imageBytes: imageBytes,
                        error: imageErrorMessage,
                        pickImage: _pickImage,
                        deleteImage: _deleteImage),
                  ),
                  const Label(
                      text: "ESPÉCIE",
                      margin: EdgeInsets.only(top: 0),
                      color: Design.primaryYellow),
                  const Label(
                      text: "SEXO",
                      margin: EdgeInsets.only(top: 20),
                      color: Design.primaryYellow),
                  const Label(
                      text: "PORTE",
                      margin: EdgeInsets.only(top: 20),
                      color: Design.primaryYellow),
                  const Label(
                      text: "IDADE",
                      margin: EdgeInsets.only(top: 20),
                      color: Design.primaryYellow),
                  const Label(
                      text: "TEMPERAMENTO",
                      margin: EdgeInsets.only(top: 20),
                      color: Design.primaryYellow),
                  Input(
                    controller: nomeController,
                    placeholder: "Doenças do animal",
                  ),
                  isAdopt ? const AdoptWidget() : Container(),
                  isFoster ? const FosterWidget() : Container(),
                  isHelp ? const HelpWidget() : Container(),
                  const Label(
                      text: "SOBRE O ANIMAL",
                      margin: EdgeInsets.only(top: 20),
                      color: Design.primaryYellow),
                  Input(
                    controller: nomeController,
                    placeholder: "Compartilhe a história do animal",
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Button(
                          width: 232,
                          value: isAdopt
                              ? "COLOCAR PARA ADOÇÃO"
                              : isFoster
                                  ? "PROCURAR PADRINHO"
                                  : "PROCURAR AJUDA",
                          onPressed: _handleRegister),
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
