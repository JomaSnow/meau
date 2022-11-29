import 'dart:developer';

import 'package:app/api/user_functions.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/util/design.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/custom_app_bar.dart';
import 'package:app/widgets/custom_drawer.dart';
import 'package:app/widgets/custom_paragraph.dart';
import 'package:app/widgets/link_button.dart';
import 'package:app/widgets/page_title.dart';
import 'package:app/widgets/scrollable_container.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({super.key});

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
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const CustomAppBar(
            iconsColor: Design.lightBlue, transparentBackground: true),
        drawer: const CustomDrawer(),
        body: ScrollableContainer(
          horizontalPadding: 63,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ),
        ));
  }
}
