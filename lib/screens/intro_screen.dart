import 'package:app/api/user_functions.dart';
import 'package:app/screens/adopt_screen.dart';
import 'package:app/screens/help_screen.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/screens/no_account_screen.dart';
import 'package:app/screens/pet_register_screen.dart';
import 'package:app/util/design.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/custom_paragraph.dart';
import 'package:app/widgets/link_button.dart';
import 'package:app/widgets/page_template.dart';
import 'package:app/widgets/page_title.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      appBarIconsColor: Design.lightBlue,
      appBarTransparentBackground: true,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      horizontalPadding: 63,
      children: [
        const PageTitle(title: "Olá!"),
        const CustomParagraph(
            value:
                "Bem-vindo ao Meau!\nAqui você pode adotar, doar e ajudar cães e gatos com facilidade.\nQual o seu interesse?"),
        Column(
          children: [
            Button(
              value: "ADOTAR",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdoptScreen(),
                    ));
              },
            ),
            Button(
              value: "AJUDAR",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpScreen(),
                    ));
              },
            ),
            Button(
              value: "CADASTRAR ANIMAL",
              onPressed: () {
                isLoggedIn()
                    ? Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PetRegisterScreen(),
                        ))
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NoAccountScreen(),
                        ));
              },
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
