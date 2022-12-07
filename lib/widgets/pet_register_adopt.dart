import 'package:app/widgets/input_checkbox.dart';
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

  void _onChanged(bool? checked) {
    String currentExigencias;
    if (!checked!) {
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

  @override
  Widget build(BuildContext context) {
    return Wrap(
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
    );
  }
}
