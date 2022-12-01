import 'package:app/screens/register_screen.dart';
import 'package:app/util/design.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/custom_paragraph.dart';
import 'package:app/widgets/page_title.dart';
import 'package:flutter/material.dart';
import '../widgets/page_template.dart';
import 'login_screen.dart';

class NoAccountScreen extends StatelessWidget {
  const NoAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      showDrawer: false,
      appBarBackgroundColor: Design.lightBlue,
      horizontalPadding: 63,
      title: "Cadastro",
      children: [
        const PageTitle(title: "Ops!", color: Design.lightBlue),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              const CustomParagraph(
                  value:
                      "Você não pode realizar esta ação sem possuir um cadastro."),
              Button(
                  value: "FAZER CADASTRO",
                  color: Design.lightBlue,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ));
                  }),
            ],
          ),
        ),
        const CustomParagraph(value: "Já possui cadastro?"),
        Button(
            value: "FAZER LOGIN",
            color: Design.lightBlue,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ));
            }),
      ],
    );
  }
}
