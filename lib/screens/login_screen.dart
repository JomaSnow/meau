import 'package:app/api/user_functions.dart';
import 'package:app/screens/intro_screen.dart';
import 'package:app/screens/register_screen.dart';
import 'package:app/util/design.dart';
import 'package:app/util/dismiss_focus.dart';
import 'package:app/util/validations.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/error_message.dart';
import 'package:app/widgets/input_text.dart';
import 'package:app/widgets/link_button.dart';
import 'package:app/widgets/page_template.dart';
import 'package:flutter/material.dart';

import '../widgets/loading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  String errorMessage = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: "Login",
      showDrawer: false,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 40, 0, 34),
          child: Form(
            key: _loginFormKey,
            child: Column(
              children: [
                InputText(
                    controller: usernameController,
                    type: TextInputType.emailAddress,
                    validationAction: (String? value) {
                      return LoginValidations.validateUsername(value);
                    },
                    styleColor: Design.lightBlue,
                    placeholder: "Nome de usuário"),
                InputText(
                    controller: passwordController,
                    type: TextInputType.text,
                    validationAction: (String? value) {
                      return LoginValidations.validatePassword(value);
                    },
                    styleColor: Design.lightBlue,
                    placeholder: "Senha",
                    isPassword: true),
              ],
            ),
          ),
        ),
        Column(
          children: [
            loading
                ? const Loading()
                : ErrorMessage(errorMessage: errorMessage),
            Button(
              value: "ENTRAR",
              disabled: loading,
              onPressed: () async {
                setState(() {
                  errorMessage = "";
                  loading = true;
                });
                dismissFocus(context);
                if (_loginFormKey.currentState!.validate()) {
                  String signInStatus = await signIn(
                      usernameController.text, passwordController.text);
                  if (!mounted) return;
                  if (signInStatus.isEmpty) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IntroScreen()));
                  } else {
                    setState(() {
                      errorMessage = signInStatus;
                    });
                  }
                }
                setState(() {
                  loading = false;
                });
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
    );
  }
}
