import 'dart:developer';

import 'package:app/util/design.dart';
import 'package:app/util/dismiss_focus.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/custom_app_bar.dart';
import 'package:app/widgets/input.dart';
import 'package:app/widgets/scrollable_container.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  void _login() {
    log("login with username ${usernameController.text} and password ${passwordController.text}");
  }

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(
        title: "Login",
        leadingIcon: null,
      ),
      drawer: const Drawer(),
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
            Button(
              value: "ENTRAR",
              onPressed: () {
                dismissFocus(context);
                _login();
              },
              color: Design.lightBlue,
              width: 232,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
              child: Column(
                children: [
                  Button(
                    value: "ENTRAR COM FACEBOOK",
                    onPressed: _login,
                    color: Design.facebook,
                    fontColor: Design.white,
                    width: 232,
                  ),
                  Button(
                    value: "ENTRAR COM GOOGLE",
                    onPressed: _login,
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
