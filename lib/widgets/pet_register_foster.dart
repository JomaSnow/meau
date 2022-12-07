import 'package:app/util/design.dart';
import 'package:app/widgets/input_checkbox.dart';
import 'package:app/widgets/label.dart';
import 'package:flutter/material.dart';

class FosterWidget extends StatefulWidget {
  const FosterWidget({
    super.key,
    required this.exigencias,
    required this.changeExigencias,
  });

  final String exigencias;
  final Function(String?) changeExigencias;

  @override
  State<FosterWidget> createState() => FosterWidgetState();
}

class FosterWidgetState extends State<FosterWidget> {
  // exigencias
  List<bool> exigencias1BoolArray = [
    false,
    false,
  ];
  bool exigencia2Bool = false;
  final List<String> exigencias1StringArray = [
    "Termo de apadrinhamento",
    "Auxílio financeiro",
  ];
  final String exigencia2String = "Visitas ao animal";

  String newExigencias = "";
  int index = 0;

  // finance
  List<bool> financeBoolArray = [
    false,
    false,
    false,
  ];
  final List<String> financeStringArray = [
    "Alimentação",
    "Saúde",
    "Objetos",
  ];

  String newFinance = "";
  int financeIndex = 0;

  void _onChanged(bool? checked) {
    String currentExigencias;
    if (!checked!) {
      if (index == 1) {
        currentExigencias = newExigencias.replaceAll(
            "${exigencias1StringArray[1]} com $newFinance",
            "${exigencias1StringArray[1]}, ");

        setState(() {
          newExigencias = currentExigencias;
          newFinance = "";
          for (int i = 0; i < financeBoolArray.length; i++) {
            financeBoolArray[i] = false;
          }
        });
      }
      currentExigencias =
          newExigencias.replaceAll("${exigencias1StringArray[index]}, ", "");
      setState(() {
        newExigencias = currentExigencias;
        exigencias1BoolArray[index] = false;
      });
    } else {
      currentExigencias = "$newExigencias${exigencias1StringArray[index]}, ";
      setState(() {
        newExigencias = currentExigencias;
        exigencias1BoolArray[index] = true;
      });
    }
    widget.changeExigencias(newExigencias.isNotEmpty
        ? newExigencias.trim().replaceRange(newExigencias.length - 2, null, ".")
        : "");
  }

  void _onFinanceChanged(bool? checked) {
    String currentFinance;
    setState(() {
      newExigencias = newExigencias.replaceAll(
          "${exigencias1StringArray[1]} com $newFinance",
          "${exigencias1StringArray[1]}, ");
    });
    if (!checked!) {
      currentFinance =
          newFinance.replaceAll("${financeStringArray[financeIndex]}, ", "");

      setState(() {
        newFinance = currentFinance;
        financeBoolArray[financeIndex] = false;
      });
    } else {
      currentFinance = "$newFinance${financeStringArray[financeIndex]}, ";
      setState(() {
        newFinance = currentFinance;
        financeBoolArray[financeIndex] = true;
      });
    }
    setState(() {
      newExigencias = newFinance.isNotEmpty
          ? newExigencias.replaceAll(exigencias1StringArray[1],
              "${exigencias1StringArray[1]} com ${newFinance.trim().replaceFirst(",", "", newFinance.length - 2)}")
          : newExigencias;
    });

    widget.changeExigencias(newExigencias.isNotEmpty
        ? newExigencias.trim().replaceRange(newExigencias.length - 2, null, ".")
        : "");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Label(
          text: "EXIGÊNCIAS PARA APADRINHAMENTO",
          color: Design.primaryYellow,
        ),
        Wrap(
          children: exigencias1StringArray.map((elem) {
            setState(() {
              index = exigencias1StringArray.indexOf(elem);
            });
            return InputSingleCheckbox(
              onChanged: (bool? checked) {
                setState(() {
                  index = exigencias1StringArray.indexOf(elem);
                });
                return _onChanged(checked);
              },
              value: exigencias1BoolArray[index],
              title: elem,
              singleLine: true,
            );
          }).toList(),
        ),
        Container(
          margin: const EdgeInsets.only(left: 40),
          child: Wrap(
            children: financeStringArray.map((elem) {
              setState(() {
                financeIndex = financeStringArray.indexOf(elem);
              });
              return InputSingleCheckbox(
                onChanged: (bool? checked) {
                  setState(() {
                    financeIndex = financeStringArray.indexOf(elem);
                  });
                  return _onFinanceChanged(checked);
                },
                value: financeBoolArray[financeIndex],
                title: elem,
                singleLine: true,
                enabled: exigencias1BoolArray[1],
              );
            }).toList(),
          ),
        ),
        InputSingleCheckbox(
          onChanged: (bool? checked) {
            String currentExigencias;
            if (!checked!) {
              currentExigencias =
                  newExigencias.replaceAll("$exigencia2String, ", "");
              setState(() {
                newExigencias = currentExigencias;
                exigencia2Bool = false;
              });
            } else {
              currentExigencias = "$newExigencias$exigencia2String, ";
              setState(() {
                newExigencias = currentExigencias;
                exigencia2Bool = true;
              });
            }
            widget.changeExigencias(newExigencias.isNotEmpty
                ? newExigencias
                    .trim()
                    .replaceRange(newExigencias.length - 2, null, ".")
                : "");
          },
          value: exigencia2Bool,
          title: exigencia2String,
          singleLine: true,
        )
      ],
    );
  }
}
