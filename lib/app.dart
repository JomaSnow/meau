import 'package:app/screens/login_screen.dart';
import 'package:app/util/dismiss_focus.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        dismissFocus(context);
      },
      child: MaterialApp(
        title: "Meau",
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
