import 'package:app/api/user_functions.dart';
import 'package:app/screens/intro_screen.dart';
import 'package:app/screens/register_screen.dart';
import 'package:app/util/design.dart';
import 'package:app/util/dismiss_focus.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/custom_app_bar.dart';
import 'package:app/widgets/error_message.dart';
import 'package:app/widgets/input.dart';
import 'package:app/widgets/link_button.dart';
import 'package:app/widgets/scrollable_container.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(
        title: "Login",
      ),
      body: ScrollableContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 40, 0, 34),
              child: Column(
                children: [
                  Input(
                      controller: usernameController,
                      styleColor: Design.lightBlue,
                      placeholder: "Nome de usuário"),
                  Input(
                      controller: passwordController,
                      styleColor: Design.lightBlue,
                      placeholder: "Senha",
                      isPassword: true),
                ],
              ),
            ),
            Column(
              children: [
                ErrorMessage(errorMessage: errorMessage),
                Button(
                  value: "ENTRAR",
                  onPressed: () async {
                    setState(() {
                      errorMessage = "";
                    });
                    dismissFocus(context);
                    String signInStatus = await signIn(
                        usernameController.text, passwordController.text);
                    if (!mounted) return;
                    if (signInStatus.isEmpty) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IntroScreen()));
                    } else {
                      setState(() {
                        errorMessage = signInStatus;
                      });
                    }
                  },
                  color: Design.lightBlue,
                  width: 232,
                ),
                LinkButton(
                    value: "crie uma conta",
                    width: 120,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()));
                    },
                    fontColor: Design.lightBlue),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
              child: Column(
                children: [
                  Button(
                    value: "ENTRAR COM FACEBOOK",
                    onPressed: () {},
                    color: Design.facebook,
                    fontColor: Design.white,
                    width: 232,
                  ),
                  Button(
                    value: "ENTRAR COM GOOGLE",
                    onPressed: () {},
                    color: Design.google,
                    fontColor: Design.white,
                    width: 232,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
