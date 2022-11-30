import 'dart:developer';

import 'package:app/api/user_functions.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/util/design.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/custom_paragraph.dart';
import 'package:app/widgets/link_button.dart';
import 'package:app/widgets/page_template.dart';
import 'package:app/widgets/page_title.dart';
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

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      appBarIconsColor: Design.lightBlue,
      appBarTransparentBackground: true,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      horizontalPadding: 63,
      children: [
        const PageTitle(title: "Olá!"),
        Column(
          children: const [
            CustomParagraph(value: "Bem-vindo ao Meau!"),
            CustomParagraph(
                value:
                    "Aqui você pode adotar, doar e ajudar cães e gatos com facilidade."),
            CustomParagraph(value: "Qual o seu interesse?"),
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
        isLoggedIn()
            ? const SizedBox(
                height: 42,
              )
            : LinkButton(
                value: "login",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
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
    );
  }
}
