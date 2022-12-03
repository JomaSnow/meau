import 'package:app/util/design.dart';
import 'package:app/widgets/button.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../widgets/page_template.dart';

class PetRegisterScreen extends StatefulWidget {
  const PetRegisterScreen({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  State<PetRegisterScreen> createState() => _PetRegisterScreenState();
}

class _PetRegisterScreenState extends State<PetRegisterScreen> {
  bool isAdopt = false;
  bool isFoster = false;
  bool isHelp = false;

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: "Cadastro do Animal",
      appBarBackgroundColor: Design.primaryYellow,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 6),
                child: Button(
                  value: "ADOTAR",
                  onPressed: () {
                    setState(() {
                      isAdopt = !isAdopt;
                    });
                  },
                  color: isAdopt ? Design.primaryYellow : Design.white2,
                  disabled: isFoster,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 6),
                child: Button(
                  value: "APDARINHAR",
                  onPressed: () {
                    setState(() {
                      isFoster = !isFoster;
                    });
                  },
                  color: isFoster ? Design.primaryYellow : Design.white1,
                  disabled: isAdopt,
                ),
              ),
            ),
            Expanded(
              child: Button(
                value: "AJUDA",
                onPressed: () {
                  setState(() {
                    isHelp = !isHelp;
                  });
                },
                color: isHelp ? Design.primaryYellow : Design.white1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
