import 'package:app/screens/my_pets_screen.dart';
import 'package:app/util/design.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/custom_paragraph.dart';
import 'package:app/widgets/page_template.dart';
import 'package:app/widgets/page_title.dart';
import 'package:flutter/material.dart';

class PetRegisterSuccessScreen extends StatelessWidget {
  const PetRegisterSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: "Cadastro do Animal",
      appBarBackgroundColor: Design.lightYellow,
      showDrawer: false,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      horizontalPadding: 70,
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 40),
              child: const PageTitle(title: "Eba!"),
            ),
            const CustomParagraph(
              value: "O cadastro do seu pet foi realizado com sucesso!",
            ),
            const CustomParagraph(
              value:
                  "Certifique-se que permitiu o envio de notificações por push no campo privacidade do menu configurações do aplicativo. Assim, poderemos te avisar assim que alguém interessado entrar em contato!",
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 24),
          child: Button(
              value: "MEUS PETS",
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyPetsScreen(),
                    ));
              }),
        )
      ],
    );
  }
}
