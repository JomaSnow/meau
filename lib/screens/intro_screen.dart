import 'package:app/api/user_functions.dart';
import 'package:app/models/user_model.dart';
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

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  UserModel? currentUser;

  @override
  void initState() {
    _setCurrentUser();
    super.initState();
  }

  void _setCurrentUser() async {
    UserModel? user = await getCurrentUser();
    if (user != null) {
      setState(() {
        currentUser = user;
      });
    }
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
                    ? Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return PetRegisterScreen(
                            user: currentUser!,
                          );
                        },
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
