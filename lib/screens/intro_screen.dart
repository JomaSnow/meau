import 'dart:developer';

import 'package:app/util/design.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/intro_paragraph.dart';
import 'package:app/widgets/page_title.dart';
import 'package:flutter/widgets.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  void _adoptFunction() {
    log("adotar");
    return;
  }

  void _helpFunction() {
    log("ajudar");
    return;
  }

  void _registerFunction() {
    log("cadastrar animal");
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Design.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 63),
          child: Column(
            children: [
              const PageTitle(title: "Olá!"),
              const IntroParagraph(value: "Bem-vindo ao Meau!"),
              const IntroParagraph(
                  value:
                      "Aqui você pode adotar, doar e ajudar cães e gatos com facilidade."),
              const IntroParagraph(value: "Qual o seu interesse?"),
              Button(
                  value: "ADOTAR",
                  onPressed: (() {
                    _adoptFunction();
                  })),
              Button(
                value: "AJUDAR",
                onPressed: () {
                  _helpFunction();
                },
              ),
              Button(
                value: "CADASTRAR ANIMAL",
                onPressed: () {
                  _registerFunction();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
