import 'package:app/widgets/input_radio.dart';
import 'package:flutter/material.dart';

class AdoptWidget extends StatefulWidget {
  const AdoptWidget({
    super.key,
    required this.exigencias,
    required this.exigenciasArray,
    required this.changeExigencias,
  });

  final String exigencias;
  final List<String> exigenciasArray;
  final Function(String?) changeExigencias;

  @override
  State<AdoptWidget> createState() => _AdoptWidgetState();
}

class _AdoptWidgetState extends State<AdoptWidget> {
  @override
  Widget build(BuildContext context) {
    return InputRadio(
      groupValue: widget.exigencias,
      onChanged: widget.changeExigencias,
      valueArray: widget.exigenciasArray,
      singleLine: true,
    );
  }
}
