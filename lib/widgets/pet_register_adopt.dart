import 'package:app/util/design.dart';
import 'package:app/widgets/input_checkbox.dart';
import 'package:app/widgets/label.dart';
import 'package:flutter/material.dart';

class AdoptWidget extends StatefulWidget {
  const AdoptWidget({
    super.key,
    required this.exigencias,
    required this.changeExigencias,
  });

  final String exigencias;
  final Function(String?) changeExigencias;

  @override
  State<AdoptWidget> createState() => _AdoptWidgetState();
}

class _AdoptWidgetState extends State<AdoptWidget> {
  // exigencias
  List<bool> exigenciasBoolArray = [
    false,
    false,
    false,
    false,
  ];
  List<String> exigenciasStringArray = [
    "Termo de adoção",
    "Fotos da casa",
    "Visita prévia ao animal",
    "Acompanhamento pós adoção",
  ];

  String newExigencias = "";
  int index = 0;

  // period
  List<bool> periodBoolArray = [
    false,
    false,
    false,
  ];
  List<String> periodStringArray = [
    "1 mês",
    "3 meses",
    "6 meses",
  ];

  String newPeriod = "";
  int periodIndex = 0;

  void _onChanged(bool? checked) {
    String currentExigencias;
    if (!checked!) {
      if (index == 3) {
        currentExigencias = newExigencias.replaceAll(
            "${exigenciasStringArray[3]} por $newPeriod",
            "${exigenciasStringArray[3]}, ");

        setState(() {
          newExigencias = currentExigencias;
          newPeriod = "";
          for (int i = 0; i < periodBoolArray.length; i++) {
            periodBoolArray[i] = false;
          }
        });
      }
      currentExigencias =
          newExigencias.replaceAll("${exigenciasStringArray[index]}, ", "");
      setState(() {
        newExigencias = currentExigencias;
        exigenciasBoolArray[index] = false;
      });
    } else {
      currentExigencias = "$newExigencias${exigenciasStringArray[index]}, ";
      setState(() {
        newExigencias = currentExigencias;
        exigenciasBoolArray[index] = true;
      });
    }
    widget.changeExigencias(newExigencias.isNotEmpty
        ? newExigencias.trim().replaceRange(newExigencias.length - 2, null, ".")
        : "");
  }

  void _onPeriodChanged(bool? checked) {
    String currentPeriod;
    setState(() {
      newExigencias = newExigencias.replaceAll(
          "${exigenciasStringArray[3]} por $newPeriod",
          "${exigenciasStringArray[3]}, ");
    });
    if (!checked!) {
      currentPeriod =
          newPeriod.replaceAll("${periodStringArray[periodIndex]}, ", "");

      setState(() {
        newPeriod = currentPeriod;
        periodBoolArray[periodIndex] = false;
      });
    } else {
      currentPeriod = "$newPeriod${periodStringArray[periodIndex]}, ";
      setState(() {
        newPeriod = currentPeriod;
        periodBoolArray[periodIndex] = true;
      });
    }
    setState(() {
      newExigencias = newPeriod.isNotEmpty
          ? newExigencias.replaceAll(exigenciasStringArray[3],
              "${exigenciasStringArray[3]} por ${newPeriod.trim().replaceFirst(",", "", newPeriod.length - 2)}")
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
          text: "EXIGÊNCIAS PARA ADOÇÃO",
          color: Design.primaryYellow,
        ),
        Wrap(
          children: exigenciasStringArray.map((elem) {
            setState(() {
              index = exigenciasStringArray.indexOf(elem);
            });
            return InputSingleCheckbox(
              onChanged: (bool? checked) {
                setState(() {
                  index = exigenciasStringArray.indexOf(elem);
                });
                return _onChanged(checked);
              },
              value: exigenciasBoolArray[index],
              title: elem,
              singleLine: true,
            );
          }).toList(),
        ),
        Container(
          margin: const EdgeInsets.only(left: 40),
          child: Wrap(
            children: periodStringArray.map((elem) {
              setState(() {
                periodIndex = periodStringArray.indexOf(elem);
              });
              return InputSingleCheckbox(
                onChanged: (bool? checked) {
                  setState(() {
                    periodIndex = periodStringArray.indexOf(elem);
                  });
                  return _onPeriodChanged(checked);
                },
                value: periodBoolArray[periodIndex],
                title: elem,
                singleLine: true,
                enabled: exigenciasBoolArray[3],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
