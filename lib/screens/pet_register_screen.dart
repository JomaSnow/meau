import 'dart:developer';

import 'package:app/api/pet_functions.dart';
import 'package:app/models/pet_model.dart';
import 'package:app/screens/adopt_screen.dart';
import 'package:app/util/design.dart';
import 'package:app/util/dismiss_focus.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/custom_paragraph.dart';
import 'package:app/widgets/image_picker_multiple_button.dart';
import 'package:app/widgets/input_checkbox.dart';
import 'package:app/widgets/input_radio.dart';
import 'package:app/widgets/input_text.dart';
import 'package:app/widgets/label.dart';
import 'package:app/widgets/pet_register_adopt.dart';
import 'package:app/widgets/pet_register_foster.dart';
import 'package:app/widgets/pet_register_help.dart';
import 'package:app/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user_model.dart';
import '../widgets/error_message.dart';
import '../widgets/loading.dart';
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
  String exigencias = "";
  String foster = "";

  String especie = "";
  final List<String> especieArray = [
    "Cachorro",
    "Gato",
  ];
  String sexo = "";
  final List<String> sexoArray = [
    "Macho",
    "Fêmea",
  ];
  String porte = "";
  final List<String> porteArray = [
    "Pequeno",
    "Médio",
    "Grande",
  ];
  String idade = "";
  final List<String> idadeArray = [
    "Filhote",
    "Adulto",
    "Idoso",
  ];
  String temperamento = "";
  String newTemperamento = "";
  int temperamentoIndex = 0;
  final List<String> temperamentoStringArray = [
    "Brincalhão",
    "Tímido",
    "Calmo",
    "Guarda",
    "Amoroso",
    "Preguiçoso",
  ];
  List<bool> temperamentoBoolArray = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  String saude = "";
  String newSaude = "";
  int saudeIndex = 0;
  final List<String> saudeStringArray = [
    "Vacinado",
    "Vermifugado",
    "Castrado",
    "Doente",
  ];
  List<bool> saudeBoolArray = [
    false,
    false,
    false,
    false,
  ];
  final doencasController = TextEditingController();
  final sobreController = TextEditingController();

  bool isAdopt = false;
  bool isFoster = false;
  bool isHelp = false;
  String imageErrorMessage = "";
  List<Uint8List?> imageBytes = [];

  final ImagePicker _picker = ImagePicker();
  // final GlobalKey<FormState> _registerPetFormKey = GlobalKey<FormState>();

  String errorMessage = "";
  bool loading = false;

  void changeExigencias(String? value) {
    setState(() {
      exigencias = value!;
    });
    log(exigencias);
  }

  void changeFoster(String? value) {
    setState(() {
      foster = value!;
    });
    log(foster);
  }

  void changeEspecie(String? value) {
    setState(() {
      especie = especieArray.firstWhere(
        (element) => element == value,
        orElse: () {
          return "";
        },
      );
    });
  }

  void changeSexo(String? value) {
    setState(() {
      sexo = sexoArray.firstWhere(
        (element) => element == value,
        orElse: () {
          return "";
        },
      );
    });
  }

  void changePorte(String? value) {
    setState(() {
      porte = porteArray.firstWhere(
        (element) => element == value,
        orElse: () {
          return "";
        },
      );
    });
  }

  void changeIdade(String? value) {
    setState(() {
      idade = idadeArray.firstWhere(
        (element) => element == value,
        orElse: () {
          return "";
        },
      );
    });
  }

  void changeTemperamento(String? value) {
    setState(() {
      temperamento = value!;
    });
    log(temperamento);
  }

  void changeSaude(String? value) {
    setState(() {
      saude = value!;
    });
    log(saude);
  }

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
      imageErrorMessage = e.toString();
    }
  }

  void _deleteImage() async {
    setState(() {
      imageBytes = [];
      imageErrorMessage = "";
    });
  }

  void _onTemperamentoChanged(bool? checked) {
    String currentTemperamento;
    if (!checked!) {
      currentTemperamento = newTemperamento.replaceAll(
          "${temperamentoStringArray[temperamentoIndex]}, ", "");
      setState(() {
        newTemperamento = currentTemperamento;
        temperamentoBoolArray[temperamentoIndex] = false;
      });
    } else {
      currentTemperamento =
          "$newTemperamento${temperamentoStringArray[temperamentoIndex]}, ";
      setState(() {
        newTemperamento = currentTemperamento;
        temperamentoBoolArray[temperamentoIndex] = true;
      });
    }
    changeTemperamento(newTemperamento.isNotEmpty
        ? newTemperamento
            .trim()
            .replaceRange(newTemperamento.length - 2, null, ".")
        : "");
  }

  void _onSaudeChanged(bool? checked) {
    String currentSaude;
    if (!checked!) {
      currentSaude =
          newSaude.replaceAll("${saudeStringArray[saudeIndex]}, ", "");
      setState(() {
        newSaude = currentSaude;
        saudeBoolArray[saudeIndex] = false;
      });
    } else {
      currentSaude = "$newSaude${saudeStringArray[saudeIndex]}, ";
      setState(() {
        newSaude = currentSaude;
        saudeBoolArray[saudeIndex] = true;
      });
    }
    changeSaude(newSaude.isNotEmpty
        ? newSaude.trim().replaceRange(newSaude.length - 2, null, ".")
        : "");
  }

  void _handleRegister(BuildContext context) async {
    String signupErr = "";
    dismissFocus(context);
    setState(() {
      errorMessage = "";
      imageErrorMessage = "";
      loading = true;
    });

    CreatePetModel newPet = CreatePetModel(
        nomeController.text,
        especie,
        sexo,
        porte,
        idade,
        temperamento,
        saude,
        doencasController.text,
        exigencias,
        sobreController.text,
        widget.user.id,
        isAdopt,
        isFoster,
        isHelp);

    signupErr = await create(newPet);

    if (signupErr.isEmpty) {
      if (!mounted) return;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdoptScreen(),
          ));
    }

    setState(() {
      loading = false;
    });
  }

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
                  InputText(
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
                  InputRadio(
                      groupValue: especie,
                      valueArray: especieArray,
                      onChanged: changeEspecie),
                  const Label(
                      text: "SEXO",
                      margin: EdgeInsets.only(top: 20),
                      color: Design.primaryYellow),
                  InputRadio(
                      groupValue: sexo,
                      valueArray: sexoArray,
                      onChanged: changeSexo),
                  const Label(
                      text: "PORTE",
                      margin: EdgeInsets.only(top: 20),
                      color: Design.primaryYellow),
                  InputRadio(
                      groupValue: porte,
                      valueArray: porteArray,
                      onChanged: changePorte),
                  const Label(
                      text: "IDADE",
                      margin: EdgeInsets.only(top: 20),
                      color: Design.primaryYellow),
                  InputRadio(
                      groupValue: idade,
                      valueArray: idadeArray,
                      onChanged: changeIdade),
                  const Label(
                      text: "TEMPERAMENTO",
                      margin: EdgeInsets.only(top: 20),
                      color: Design.primaryYellow),
                  Wrap(
                    children: temperamentoStringArray.map((elem) {
                      setState(() {
                        temperamentoIndex =
                            temperamentoStringArray.indexOf(elem);
                      });
                      return InputSingleCheckbox(
                        onChanged: (bool? checked) {
                          setState(() {
                            temperamentoIndex =
                                temperamentoStringArray.indexOf(elem);
                          });
                          return _onTemperamentoChanged(checked);
                        },
                        value: temperamentoBoolArray[temperamentoIndex],
                        title: elem,
                      );
                    }).toList(),
                  ),
                  const Label(
                      text: "SAÚDE",
                      margin: EdgeInsets.only(top: 20),
                      color: Design.primaryYellow),
                  Wrap(
                    children: saudeStringArray.map((elem) {
                      setState(() {
                        saudeIndex = saudeStringArray.indexOf(elem);
                      });
                      return InputSingleCheckbox(
                        onChanged: (bool? checked) {
                          setState(() {
                            saudeIndex = saudeStringArray.indexOf(elem);
                          });
                          return _onSaudeChanged(checked);
                        },
                        value: saudeBoolArray[saudeIndex],
                        title: elem,
                      );
                    }).toList(),
                  ),
                  InputText(
                    controller: doencasController,
                    placeholder: "Doenças do animal",
                  ),
                  isAdopt
                      ? AdoptWidget(
                          changeExigencias: changeExigencias,
                          exigencias: exigencias,
                        )
                      : Container(),
                  isFoster
                      ? FosterWidget(
                          changeExigencias: changeFoster,
                          exigencias: foster,
                        )
                      : Container(),
                  isHelp ? const HelpWidget() : Container(),
                  const Label(
                      text: "SOBRE O ANIMAL",
                      margin: EdgeInsets.only(top: 20),
                      color: Design.primaryYellow),
                  InputText(
                    controller: sobreController,
                    placeholder: "Compartilhe a história do animal",
                  ),
                  Center(
                    child: Column(
                      children: [
                        loading
                            ? const Loading()
                            : ErrorMessage(errorMessage: errorMessage),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: Button(
                              width: 232,
                              value: isAdopt
                                  ? "COLOCAR PARA ADOÇÃO"
                                  : isFoster
                                      ? "PROCURAR PADRINHO"
                                      : "PROCURAR AJUDA",
                              onPressed: () {
                                _handleRegister(context);
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
