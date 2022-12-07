import 'package:app/api/pet_functions.dart';
import 'package:app/models/pet_model.dart';
import 'package:app/screens/intro_screen.dart';
import 'package:app/screens/pet_register_success_screen.dart';
import 'package:app/util/design.dart';
import 'package:app/util/dismiss_focus.dart';
import 'package:app/util/validations.dart';
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
  final medicamentoController = TextEditingController();
  final objetosController = TextEditingController();
  String exigencias = "";
  String necessidades = "";
  String foster = "";

  String especie = "";
  String especieErrorMsg = "";
  final List<String> especieArray = [
    "Cachorro",
    "Gato",
  ];
  String sexo = "";
  String sexoErrorMsg = "";
  final List<String> sexoArray = [
    "Macho",
    "Fêmea",
  ];
  String porte = "";
  String porteErrorMsg = "";
  final List<String> porteArray = [
    "Pequeno",
    "Médio",
    "Grande",
  ];
  String idade = "";
  String idadeErrorMsg = "";
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
  final GlobalKey<FormState> _registerPetFormKey = GlobalKey<FormState>();

  String errorMessage = "";
  bool loading = false;

  void changeExigencias(String? value) {
    setState(() {
      exigencias = value!;
    });
  }

  void changeFoster(String? value) {
    setState(() {
      foster = value!;
    });
  }

  void changeNecessidades(String? value) {
    setState(() {
      necessidades = value!;
    });
  }

  void changeEspecie(String? value) {
    setState(() {
      especieErrorMsg = "";
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
      sexoErrorMsg = "";
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
      porteErrorMsg = "";
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
      idadeErrorMsg = "";
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
  }

  void changeSaude(String? value) {
    setState(() {
      saude = value!;
    });
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

    if (!saude.contains("Doente")) {
      doencasController.text = "";
    }
    if (!necessidades.contains("Objetos")) {
      objetosController.text = "";
    }
    if (!necessidades.contains("Medicamento")) {
      medicamentoController.text = "";
    }

    if (_registerPetFormKey.currentState!.validate()) {
      if (especie.isEmpty) {
        setState(() {
          especieErrorMsg = "Selecione uma espécie.";
          signupErr = "Preencha todos os campos.";
        });
      }
      if (sexo.isEmpty) {
        setState(() {
          sexoErrorMsg = "Selecione um sexo.";
          signupErr = "Preencha todos os campos.";
        });
      }
      if (porte.isEmpty) {
        setState(() {
          porteErrorMsg = "Selecione um porte.";
          signupErr = "Preencha todos os campos.";
        });
      }
      if (idade.isEmpty) {
        setState(() {
          idadeErrorMsg = "Selecione uma idade.";
          signupErr = "Preencha todos os campos.";
        });
      }

      if (imageBytes.length < 3) {
        setState(() {
          imageErrorMessage = "Selecione ao menos 3 imagens.";
          loading = false;
        });
        return;
      }

      for (var img in imageBytes) {
        const int fileSizeLimitBytes = 4000000; // 4MB
        int imageBytesSize = img!.length;
        final bool isValidSize = imageBytesSize < fileSizeLimitBytes;
        if (!isValidSize) {
          setState(() {
            imageErrorMessage =
                "Arquivos excedem tamanho máximo por foto (4MB).";
            loading = false;
          });
          return;
        }
      }

      try {
        if (signupErr.isEmpty) {
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
            foster,
            necessidades,
            medicamentoController.text,
            objetosController.text,
            sobreController.text,
            widget.user.id,
            isAdopt,
            isFoster,
            isHelp,
            imageBytes,
          );

          signupErr = await create(newPet);
        }
      } catch (e) {
        signupErr = e.toString();
      }

      if (signupErr.isEmpty) {
        if (!mounted) return;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const IntroScreen(),
            ));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PetRegisterSuccessScreen(),
            ));
      }
    }

    setState(() {
      errorMessage = signupErr;
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
            ? Form(
                key: _registerPetFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.only(top: 20),
                      width: 1000,
                      decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Design.lightestGray, width: 1)),
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
                        color: Design.darkYellow),
                    InputText(
                      controller: nomeController,
                      placeholder: "Nome do animal",
                      validationAction: (String? value) {
                        return PetRegisterValidations.validateName(value);
                      },
                    ),
                    const Label(
                        text: "FOTOS DO ANIMAL",
                        margin: EdgeInsets.only(top: 20),
                        color: Design.darkYellow),
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
                        color: Design.darkYellow),
                    InputRadio(
                        groupValue: especie,
                        error: especieErrorMsg,
                        valueArray: especieArray,
                        onChanged: changeEspecie),
                    const Label(
                        text: "SEXO",
                        margin: EdgeInsets.only(top: 20),
                        color: Design.darkYellow),
                    InputRadio(
                        groupValue: sexo,
                        error: sexoErrorMsg,
                        valueArray: sexoArray,
                        onChanged: changeSexo),
                    const Label(
                        text: "PORTE",
                        margin: EdgeInsets.only(top: 20),
                        color: Design.darkYellow),
                    InputRadio(
                        groupValue: porte,
                        error: porteErrorMsg,
                        valueArray: porteArray,
                        onChanged: changePorte),
                    const Label(
                        text: "IDADE",
                        margin: EdgeInsets.only(top: 20),
                        color: Design.darkYellow),
                    InputRadio(
                        groupValue: idade,
                        error: idadeErrorMsg,
                        valueArray: idadeArray,
                        onChanged: changeIdade),
                    const Label(
                        text: "TEMPERAMENTO",
                        margin: EdgeInsets.only(top: 20),
                        color: Design.darkYellow),
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
                        color: Design.darkYellow),
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
                    saudeBoolArray[3]
                        ? InputText(
                            controller: doencasController,
                            placeholder: "Doenças do animal",
                            validationAction: (String? value) {
                              return PetRegisterValidations.validateDoenca(
                                  value);
                            },
                          )
                        : Container(),
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
                    isHelp
                        ? HelpWidget(
                            changeNecessidades: changeNecessidades,
                            necessidades: necessidades,
                            medicamentoController: medicamentoController,
                            objetosController: objetosController,
                            showTitle: isAdopt || isFoster,
                          )
                        : Container(),
                    const Label(
                        text: "SOBRE O ANIMAL",
                        margin: EdgeInsets.only(top: 20),
                        color: Design.primaryYellow),
                    InputText(
                      controller: sobreController,
                      placeholder: "Compartilhe a história do animal",
                      validationAction: (String? value) {
                        return PetRegisterValidations.validateSobre(value);
                      },
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
                                disabled: loading,
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
                ),
              )
            : Container(),
      ],
    );
  }
}
