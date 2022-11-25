import 'dart:developer';

import 'package:app/util/design.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/custom_app_bar.dart';
import 'package:app/widgets/intro_paragraph.dart';
import 'package:app/widgets/link_button.dart';
import 'package:app/widgets/page_title.dart';
import 'package:app/widgets/scrollable_container.dart';
import 'package:flutter/material.dart';

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

  void _login() {
    log("login");
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const CustomAppBar(
            iconsColor: Design.lightBlue, transparentBackground: true),
        drawer: const Drawer(),
        body: ScrollableContainer(
          horizontalPadding: 63,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const PageTitle(title: "Olá!"),
              Column(
                children: const [
                  IntroParagraph(value: "Bem-vindo ao Meau!"),
                  IntroParagraph(
                      value:
                          "Aqui você pode adotar, doar e ajudar cães e gatos com facilidade."),
                  IntroParagraph(value: "Qual o seu interesse?"),
                ],
              ),
              Column(
                children: [
                  Button(
                    value: "ADOTAR",
                    onPressed: _adoptFunction,
                  ),
                  Button(
                    value: "AJUDAR",
                    onPressed: _helpFunction,
                  ),
                  Button(
                    value: "CADASTRAR ANIMAL",
                    onPressed: _registerFunction,
                  ),
                ],
              ),
              LinkButton(
                value: "login",
                onPressed: _login,
                width: 80,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 32),
                child: Image.asset(
                  "lib/assets/images/Meau_marca_2.png",
                  color: Design.lightBlue,
                  width: 122,
                ),
              ),
            ],
          ),
        ));
  }
}
