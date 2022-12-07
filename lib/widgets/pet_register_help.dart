import 'package:app/util/design.dart';
import 'package:app/widgets/input_checkbox.dart';
import 'package:app/widgets/input_text.dart';
import 'package:app/widgets/label.dart';
import 'package:app/widgets/section_title.dart';
import 'package:flutter/material.dart';

class HelpWidget extends StatefulWidget {
  const HelpWidget({
    super.key,
    required this.necessidades,
    required this.changeNecessidades,
    required this.medicamentoController,
    required this.objetosController,
    this.showTitle = false,
  });

  final String necessidades;
  final Function(String?) changeNecessidades;
  final TextEditingController medicamentoController;
  final TextEditingController objetosController;
  final bool showTitle;

  @override
  State<HelpWidget> createState() => HelpWidgetState();
}

class HelpWidgetState extends State<HelpWidget> {
  List<bool> necessidades1BoolArray = [
    false,
    false,
    false,
  ];
  bool necessidade2Bool = false;
  final List<String> necessidades1StringArray = [
    "Alimento",
    "Auxílio financeiro",
    "Medicamento",
  ];
  final String necessidade2String = "Objetos";

  String newNecessidades = "";
  int index = 0;

  void _onChanged(bool? checked) {
    String currentNecessidades;
    if (!checked!) {
      currentNecessidades = newNecessidades.replaceAll(
          "${necessidades1StringArray[index]}, ", "");
      setState(() {
        newNecessidades = currentNecessidades;
        necessidades1BoolArray[index] = false;
      });
    } else {
      currentNecessidades =
          "$newNecessidades${necessidades1StringArray[index]}, ";
      setState(() {
        newNecessidades = currentNecessidades;
        necessidades1BoolArray[index] = true;
      });
    }
    widget.changeNecessidades(newNecessidades.isNotEmpty
        ? newNecessidades
            .trim()
            .replaceRange(newNecessidades.length - 2, null, ".")
        : "");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.showTitle
            ? Container(
                width: 1000,
                decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Design.lightestGray, width: 1)),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: SectionTitle(
                    title: "Ajudar",
                  ),
                ),
              )
            : Container(),
        const Label(
          text: "NECESSIDADES DO ANIMAL",
          color: Design.darkYellow,
        ),
        Wrap(
          children: necessidades1StringArray.map((elem) {
            setState(() {
              index = necessidades1StringArray.indexOf(elem);
            });
            return InputSingleCheckbox(
              onChanged: (bool? checked) {
                setState(() {
                  index = necessidades1StringArray.indexOf(elem);
                });
                return _onChanged(checked);
              },
              value: necessidades1BoolArray[index],
              title: elem,
              singleLine: true,
            );
          }).toList(),
        ),
        necessidades1BoolArray[2]
            ? InputText(
                controller: widget.medicamentoController,
                placeholder: "Nome do medicamento",
              )
            : Container(),
        InputSingleCheckbox(
          onChanged: (bool? checked) {
            String currentNecessidades;
            if (!checked!) {
              currentNecessidades =
                  newNecessidades.replaceAll("$necessidade2String, ", "");
              setState(() {
                newNecessidades = currentNecessidades;
                necessidade2Bool = false;
              });
            } else {
              currentNecessidades = "$newNecessidades$necessidade2String, ";
              setState(() {
                newNecessidades = currentNecessidades;
                necessidade2Bool = true;
              });
            }
            widget.changeNecessidades(newNecessidades.isNotEmpty
                ? newNecessidades
                    .trim()
                    .replaceRange(newNecessidades.length - 2, null, ".")
                : "");
          },
          value: necessidade2Bool,
          title: necessidade2String,
          singleLine: true,
        ),
        necessidade2Bool
            ? InputText(
                controller: widget.objetosController,
                placeholder: "Especifique o(s) objeto(s)",
              )
            : Container(),
      ],
    );
  }
}
